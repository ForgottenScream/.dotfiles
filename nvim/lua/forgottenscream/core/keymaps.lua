-- lua/core/keymaps.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- =====================================================================
-- Core / config
-- =====================================================================
map("n", "<leader>rc", ":source $MYVIMRC<CR>", { desc = "Reload config" })
map("n", "<leader>ch", ":nohl<CR>", { desc = "Clear highlights" })

map("i", "tn", "<Esc>", { noremap = true, silent = true })
map("i", "<Esc>", "<Nop>", { noremap = true, silent = true })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

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
-- Windows / tabs
-- =====================================================================
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
map("n", "<leader>sl", "<C-w>l", { desc = "To right split" })

map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Prev tab" })
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buffer in new tab" })

-- =====================================================================
-- Terminal
-- =====================================================================
map("n", "<leader>tt", ":terminal<CR>", { desc = "Terminal" })
map("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal (vert)" })
map("n", "<leader>th", ":split | terminal<CR>", { desc = "Terminal (horiz)" })

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
