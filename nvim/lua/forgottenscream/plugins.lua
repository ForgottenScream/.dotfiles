-- =========================================
-- Plugin Setup (Manual pack/start)
-- =========================================

local function safe_setup(module_name, config)
	local ok, module = pcall(require, module_name)
	if ok and type(module.setup) == "function" then
		module.setup(config or {})
	end
end

-- =========================================
-- nvim-autopairs
-- =========================================

safe_setup("nvim-autopairs", {})

-- =========================================
-- nvim-surround
-- =========================================

safe_setup("nvim-surround", {})

-- =========================================
-- gitsigns
-- =========================================
local ok_gs, gitsigns = pcall(require, "gitsigns")
if ok_gs then
	gitsigns.setup({
		on_attach = function(bufnr)
			local gs = require("gitsigns")

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
					gs.nav_hunk("next")
				end
			end)

			map("n", "[c", function()
				if vim.wo.diff then
					vim.cmd.normal({ "[c", bang = true })
				else
					gs.nav_hunk("prev")
				end
			end)

			-- Actions
			map("n", "<leader>hs", gs.stage_hunk)
			map("n", "<leader>hr", gs.reset_hunk)

			map("v", "<leader>hs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end)

			map("n", "<leader>hS", gs.stage_buffer)
			map("n", "<leader>hR", gs.reset_buffer)
			map("n", "<leader>hp", gs.preview_hunk)
			map("n", "<leader>hi", gs.preview_hunk_inline)

			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end)

			map("n", "<leader>hd", gs.diffthis)

			map("n", "<leader>hD", function()
				gs.diffthis("~")
			end)

			map("n", "<leader>hQ", function()
				gs.setqflist("all")
			end)
			map("n", "<leader>hq", gs.setqflist)

			-- Toggles
			map("n", "<leader>tb", gs.toggle_current_line_blame)
			map("n", "<leader>tw", gs.toggle_word_diff)

			-- Text object
			map({ "o", "x" }, "ih", gs.select_hunk)
		end,
	})
end

-- =========================================
-- nvim-cmp
-- =========================================

local ok_cmp, cmp = pcall(require, "cmp")
if ok_cmp then
	cmp.setup({
		mapping = {
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "path" },
		},
	})

	-- Proper autopairs integration
	local ok_ap, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
	if ok_ap then
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end
end

