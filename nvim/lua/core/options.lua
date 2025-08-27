local opt = vim.opt       -- for readability

opt.relativenumber = true -- Shows line number relative to where the cursor is
opt.number = true         -- Shows absolute line number for the buffer

-- Tabs & indentation (getting this out of the way)
opt.tabstop = 4       -- 4 spaces for tabs
opt.shiftwidth = 4    -- 4 spaces for indent width
opt.expandtab = false --expand tab to spaces
opt.autoindent = true -- Copy indent from current line when starting new one
opt.spell = true
opt.spelllang = "en_gb"

opt.wrap = false --disables line wrapping

-- Spelling off for terminal
vim.api.nvim_create_autocmd({ "TermOpen" }, {
	pattern = "*",
	command = "setlocal nospell",
})

--search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- Assumes you want case-sensitive if mixed case in search

-- cursor line

opt.cursorline = true

-- appearance

opt.termguicolors = true --Useful for color schemes to work
opt.background = "dark"  --If there is an option, it will be dark.
opt.signcolumn = "yes"   --Show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- Allows backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- split windows
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- :Explorer
vim.g.netrw_banner = 0       -- Remove the annoying banner
vim.g.netrw_liststyle = 3    -- Tree-style view (1=long, 2=short, 3=tree)
vim.g.netrw_browse_split = 4 -- Open files in previous window
vim.g.netrw_altv = 1         -- When splitting vertically, open on left
vim.g.netrw_winsize = 25     -- Set default size of explorer window
