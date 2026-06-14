-- Tokyonight Moon colors
local thm_bg = "#222436"
local thm_fg = "#c8d3f5"
local thm_cyan = "#86e1fc"
local thm_black = "#1b1d2b"
local thm_gray = "#3a3f5a"
local thm_magenta = "#c099ff"
local thm_pink = "#ff757f"
local thm_red = "#ff757f"
local thm_green = "#c3e88d"
local thm_yellow = "#ffc777"
local thm_blue = "#82aaff"
local thm_orange = "#ff9e64"

vim.opt.background = "dark"
vim.api.nvim_set_hl(0, "Normal", { fg = thm_fg, bg = thm_bg })
vim.api.nvim_set_hl(0, "CursorLine", { bg = thm_black })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = thm_black })
vim.api.nvim_set_hl(0, "LineNr", { fg = thm_gray })
vim.api.nvim_set_hl(0, "StatusLine", { fg = thm_fg, bg = thm_gray })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = thm_gray, bg = thm_bg })
vim.api.nvim_set_hl(0, "Visual", { bg = thm_black4 })
vim.api.nvim_set_hl(0, "Search", { fg = thm_bg, bg = thm_yellow })
vim.api.nvim_set_hl(0, "Comment", { fg = thm_gray })
vim.api.nvim_set_hl(0, "String", { fg = thm_green })
vim.api.nvim_set_hl(0, "Number", { fg = thm_orange })
vim.api.nvim_set_hl(0, "Function", { fg = thm_blue })
vim.api.nvim_set_hl(0, "Keyword", { fg = thm_magenta })
vim.api.nvim_set_hl(0, "Type", { fg = thm_cyan })
