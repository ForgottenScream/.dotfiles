vim.g.mapleader = " "

local keymap = vim.keymap -- for readability

keymap.set("n", "<leader>rc", ":source $MYVIMRC<CR>", { desc = "Reload config" })

-- Toggle Lexplorer (netrw on the left)
vim.keymap.set("n", "<leader>e", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			vim.api.nvim_win_close(win, true)
			return
		end
	end
	vim.cmd("Lexplore")
end, { desc = "Toggle file explorer" })

keymap.set("n", "<leader>lg", ":belowright split | terminal lazygit<CR>", { desc = "Open lazygit" })

-- clear search highlights
keymap.set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>sl", "<C-w>l", { desc = "Move to right split" })

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- terminal windows
keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Vertical terminal" })
keymap.set("n", "<leader>th", ":split | terminal<CR>", { desc = "Horizontal terminal" })

-- latex auto
keymap.set("n", "<leader>la", ":lua require('core.functions').CreateLatex('zathura', 'latexmk', '-shell-escape')<CR>", { desc = "Run LaTeX Automation" })

-- LaTex Watcher Controls
local latex_job = nil

-- Start watching for LaTex changes
vim.keymap.set("n", "<leader>lw", function()
	if latex_job then
		print("LaTex watcher is already running.")
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
end, { desc = "Run LaTeX Watch in Background" })

-- Stop the watcher manually
vim.keymap.set("n", "<leader>lx", function()
    if latex_job then
        vim.fn.jobstop(latex_job)
        print("Stopped LaTeX watcher.")
        latex_job = nil
    else
        print("No LaTeX watcher is currently running.")
    end
end, { desc = "Stop LaTeX Watcher" })
