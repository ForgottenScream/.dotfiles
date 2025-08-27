vim.o.laststatus = 2 -- Always show statusline

vim.o.statusline = table.concat({
	"%#StatusLine#",
	" %f",   -- File path
	" %m",   -- Modified flag
	" %r",   -- Readonly flag
	" %= ",  -- Align right
	" %y",   -- Filetype
	" | ",
	"L:%l/%L", -- Current line / total lines
	" C:%c", -- Column
})
