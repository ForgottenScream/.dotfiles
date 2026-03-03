-- =========================================
-- Plugin Setup (Manual pack/start)
-- =========================================

local function safe_setup(name, opts, after)
	local ok, mod = pcall(require, name)
	if not ok then
		return
	end

	if type(mod.setup) == "function" then
		mod.setup(opts or {})
	end

	if type(after) == "function" then
		after(mod)
	end
end

-- =========================================
-- nvim-autopairs
-- =========================================

safe_setup("nvim-autopairs")

-- =========================================
-- nvim-surround
-- =========================================

safe_setup("nvim-surround")

-- =========================================
-- gitsigns
-- =========================================

safe_setup("gitsigns", {
	on_attach = function(bufnr)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				require("gitsigns").nav_hunk("next")
			end
		end)

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				require("gitsigns").nav_hunk("prev")
			end
		end)

		-- Actions
		map("n", "<leader>hs", require("gitsigns").stage_hunk)
		map("n", "<leader>hr", require("gitsigns").reset_hunk)

		map("v", "<leader>hs", function()
			require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("v", "<leader>hr", function()
			require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)

		map("n", "<leader>hS", require("gitsigns").stage_buffer)
		map("n", "<leader>hR", require("gitsigns").reset_buffer)
		map("n", "<leader>hp", require("gitsigns").preview_hunk)
		map("n", "<leader>hi", require("gitsigns").preview_hunk_inline)

		map("n", "<leader>hb", function()
			require("gitsigns").blame_line({ full = true })
		end)

		map("n", "<leader>hd", require("gitsigns").diffthis)

		map("n", "<leader>hD", function()
			require("gitsigns").diffthis("~")
		end)

		map("n", "<leader>hQ", function()
			require("gitsigns").setqflist("all")
		end)

		map("n", "<leader>hq", require("gitsigns").setqflist)

		-- Toggles
		map("n", "<leader>tb", require("gitsigns").toggle_current_line_blame)
		map("n", "<leader>tw", require("gitsigns").toggle_word_diff)

		-- Text object
		map({ "o", "x" }, "ih", require("gitsigns").select_hunk)
	end,
})

-- =========================================
-- nvim-cmp
-- =========================================

safe_setup("cmp", {
	mapping = {
		["<C-j>"] = require("cmp").mapping.select_next_item(),
		["<C-k>"] = require("cmp").mapping.select_prev_item(),
		["<CR>"] = require("cmp").mapping.confirm({ select = true }),
		["<C-Space>"] = require("cmp").mapping.complete(),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	},
}, function(cmp)
	local ok_ap, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	if ok_ap then
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end
end)

