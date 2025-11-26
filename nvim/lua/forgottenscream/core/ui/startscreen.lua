local banner = {
	"                                                     																															",
	"                                                     																															",
	"                                                     																															",
	"                                                     																															",
	"                                                      																															",
	"                                                      																															",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                                                             																					",
	"                                                      		███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                                                     				",
	"                                                      		████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                                                     				",
	"                                                      		██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                                                     				",
	"                                                      		██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                                                     				",
	"                                                      		██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                                                     				",
	"                                                      		╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                                                     				",
	"                                                                                                                                                             					",
	"                                                     																															",
	"                                                     																															",
	"                                                     																															",
	"                   														n > New File                      																	",
	"                                                     																															",
	"                   														f > Find File                     																	",
	"                                                     																															",
	"                   														r > Open Recent File              																	",
	"                                                     																															",
	"                   														q > Quit                          																	",
	"                                                     																															",
}

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			vim.cmd("enew")
			vim.api.nvim_buf_set_lines(0, 0, -1, false, banner)
			vim.bo.modified = false
			vim.bo.buflisted = false
			vim.bo.bufhidden = "wipe"
			vim.bo.filetype = "startscreen"

			vim.keymap.set("n", "n", ":ene<CR>", { buffer = true })
			vim.keymap.set("n", "f", ":<cmd>Telescope find_files<CR>", { buffer = true })
			vim.keymap.set("n", "r", ":<cmd>Telescope oldfiles<CR>", { buffer = true })
			vim.keymap.set("n", "q", ":qa<CR>", { buffer = true })
		end
	end,
})
