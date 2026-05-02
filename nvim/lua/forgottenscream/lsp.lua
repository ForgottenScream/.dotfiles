-- =========================================
-- LSP Keymaps & Behavior
-- =========================================

local keymap = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- Navigation
    keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    keymap(
      "n",
      "gt",
      vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" })
    )
    keymap("n", "gR", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))

    -- Actions
    keymap(
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code actions" })
    )
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))

    -- Info
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))

    -- Diagnostics
    keymap(
      "n",
      "<leader>d",
      vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
    )
    keymap("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    keymap("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = ev.buf,
      callback = function()
        if vim.b._formatting then
          return
        end

        vim.b._formatting = true

        local ft = vim.bo.filetype
        local bufnr = ev.buf

        -- Lua → StyLua
        if ft == "lua" then
          local filename = vim.api.nvim_buf_get_name(bufnr)

          local input = table.concat(
            vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
            "\n"
          )

          local output = vim.fn.system(
            { "stylua", "--stdin-filepath", filename, "-" },
            input
          )

          if vim.v.shell_error == 0 then
            local new_lines = vim.split(output, "\n", { plain = true })
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
          else
            vim.notify("StyLua formatting failed", vim.log.levels.ERROR)
          end

          vim.b._formatting = false
          return
        end

        -- Python → Ruff LSP
        if ft == "python" then
          vim.lsp.buf.format({
            async = false,
            filter = function(client)
              return client.name == "ruff"
            end,
          })
          vim.b._formatting = false
          return
        end

        -- Fallback
        vim.lsp.buf.format({ async = false })

        vim.b._formatting = false
      end,
    })
  end,
})

-- =========================================
-- Diagnostics Configuration
-- =========================================

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "X ",
      [vim.diagnostic.severity.WARN] = "! ",
      [vim.diagnostic.severity.INFO] = "? ",
      [vim.diagnostic.severity.HINT] = "i ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- =========================================
-- LSP Servers
-- =========================================

-- Ensure lspconfig registers server definitions
require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.general = capabilities.general or {}
capabilities.general.positionEncodings = { "utf-16" }

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true),
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
  pyright = {},
  ruff = {
    cmd = { "ruff", "server" },
    init_options = {
      settings = {
        lineLength = 80,
      },
    },
    hls = {},
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
