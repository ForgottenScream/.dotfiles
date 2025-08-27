local lspconfig = require("lspconfig")
local util = lspconfig.util

-- Try to detect project root
local root_dir = util.root_pattern("build.gradle", "pom.xml", ".git")(vim.fn.getcwd())
  or vim.fn.expand("%:p:h")  -- fallback to current file's directory

-- Create a workspace folder (per project or per file path)
local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. project_name

lspconfig.jdtls.setup({
  cmd = { "jdtls", "-data", workspace_dir },
  root_dir = root_dir,
})
