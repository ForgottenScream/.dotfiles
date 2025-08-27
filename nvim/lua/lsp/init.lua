local lspconfig = require("lspconfig")

-- Custom diagnostic icons
local signs = {
	Error = "X",
	Warn  = "!",
	Hint  = "?",
	Info  = "i",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Buffer-local LSP keybindings + format on save
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
				buffer = args.buf,
				desc = desc,
				silent = true,
				noremap = true,
			})
		end

		-- Navigation and info
		map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
		map("n", "gr", vim.lsp.buf.references, "Find References")
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")

		-- Code actions and refactors
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

		-- Formatting
		map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "Format Buffer")

		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
})

-- Language server configurations
require("lsp.servers.lua_ls")
require("lsp.servers.haskell")
require("lsp.servers.gopls")
require("lsp.servers.jdtls")
