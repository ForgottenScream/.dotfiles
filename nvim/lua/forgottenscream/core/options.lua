local opt = vim.opt

-- Basic Definitions
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")

-- File Handling
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = false
opt.updatetime = 300
opt.timeoutlen = 500
opt.ttimeoutlen = 0
opt.autoread = true
opt.autowrite = true

-- Visual Settings
opt.termguicolors = true
opt.background = "dark"
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.showmatch = true
opt.matchtime = 2
opt.cmdheight = 1
opt.completeopt = "menuone,noinsert,noselect"
opt.showmode = false
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0
opt.conceallevel = 0
opt.winborder = "rounded"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true

-- Search Settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Split Behavior
opt.splitbelow = true
opt.splitright = true

-- :Explorer
vim.g.netrw_banner = 0 -- Remove the annoying banner
vim.g.netrw_liststyle = 3 -- Tree-style view (1=long, 2=short, 3=tree)
vim.g.netrw_browse_split = 4 -- Open files in previous window
vim.g.netrw_altv = 1 -- When splitting vertically, open on left
vim.g.netrw_winsize = 25 -- Set default size of explorer window

-- Basic autocommands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Spelling Off for Terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup,
  pattern = "*",
  command = "setlocal nospell",
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- =====================
-- TABS
-- =====================
opt.showtabline = 1
opt.tabline = ""
