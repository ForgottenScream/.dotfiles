local lspconfig = require("lspconfig")

vim.diagnostic.config({
        signs = {
                text = {
                        [vim.diagnostic.severity.ERROR] = "X ",
                        [vim.diagnostic.severity.WARN] = "! ",
                        [vim.diagnostic.severity.INFO] = "? ",
                        [vim.diagnostic.severity.HINT] = "i ",
                },
                texthl = {
                        [vim.diagnostic.severity.ERROR] = "Error",
                        [vim.diagnostic.severity.WARN] = "Warn",
                        [vim.diagnostic.severity.HINT] = "Hint",
                        [vim.diagnostic.severity.INFO] = "Info",
                },
                numhl = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                },
        },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client.id)

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, {
        	buffer = bufnr,
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
		map("c", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

		-- Formatting
		map("n", "<leader>f", function()
			vim.lsp.buf.format({ async = true })
		end, "Format Buffer")

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- JDTLS (Java only)
    	if client and client.name == "jdtls" then
		  	local ok, jdtls = pcall(require, "jdtls")
      		if ok then
       			map("n", "<leader>oi", jdtls.organize_imports, "Java: Organize imports")
				map("n", "<leader>tc", jdtls.test_class, "Java: Test class")
        		map("n", "<leader>tm", jdtls.test_nearest_method, "Java: Test method")
      		end
  		end
	end,
})

-- Language server configurations
require("lsp.servers.lua_ls")
require("lsp.servers.haskell")
require("lsp.servers.gopls")
require("lsp.servers.jdtls")
