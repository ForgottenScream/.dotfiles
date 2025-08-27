local lspconfig = require("lspconfig")

lspconfig.hls.setup({
	settings = {
		haskell = {
			formattingProvider = "ormolu",
		},
	},
})
