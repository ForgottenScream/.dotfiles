-- lua/core/keymaps.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- =====================================================================
-- Core / config
-- =====================================================================
map("i", "tn", "<Esc>", { noremap = true, silent = true })

-- =====================================================================
-- Files / explorer
-- =====================================================================
map("n", "<leader>e", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			vim.api.nvim_win_close(win, true)
			return
		end
	end
	vim.cmd("Lexplore")
end, { desc = "Toggle file explorer" })

-- =====================================================================
-- LaTeX
-- =====================================================================
map(
	"n",
	"<leader>la",
	":lua require('core.functions').CreateLatex('zathura', 'latexmk', '-shell-escape')<CR>",
	{ desc = "Run LaTeX automation" }
)

local latex_job = nil

map("n", "<leader>lw", function()
	if latex_job then
		print("LaTeX watcher is already running.")
		return
	end

	local job_id = vim.fn.jobstart({ "make", "watch-silent" }, {
		on_exit = function(_, exit_code)
			if exit_code == 143 or exit_code == 0 then
				print("LaTeX watcher stopped.")
			else
				print("LaTeX watcher exited with code " .. exit_code)
			end
			latex_job = nil
		end,
	})

	if type(job_id) ~= "number" then
		print("Failed to start LaTeX watcher.")
		latex_job = nil
		return
	end

	latex_job = job_id
	print("Running LaTeX watch in the background...")
end, { desc = "LaTeX watch" })

map("n", "<leader>lx", function()
	if latex_job then
		vim.fn.jobstop(latex_job)
		print("Stopped LaTeX watcher.")
		latex_job = nil
	else
		print("No LaTeX watcher is currently running.")
	end
end, { desc = "Stop LaTeX watch" })

