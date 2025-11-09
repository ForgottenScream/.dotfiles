local lspconfig = require("lspconfig")
local util = lspconfig.util

lspconfig.jdtls.setup({
	root_dir = function(fname)
		return util.root_pattern("build.gradle","pom.xml", ".git")(fname)
			or vim.fn.getcwd()
	end,

	on_new_config = function(new_config, root_dir)
		local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
		new_config.cmd = {
			"jdtls",
			"-data",
			vim.fn.stdpath("data") .. "/jdtls/" .. project_name,
		}
	end,
})
