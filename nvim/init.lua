-- =========================================
-- NEOVIM CONFIGURATION
-- =========================================

-- =========================================
-- OPTIONS
-- =========================================

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard:append("unnamedplus")
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.wildignore:append({ "node_modules", ".git" })
vim.opt.showcmd = true

vim.cmd("filetype plugin indent on")

vim.opt.directory = vim.fn.expand("~/.local/share/nvim/swap//")
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undo")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = true

vim.opt.termguicolors = true

vim.opt.colorcolumn = "80"
vim.opt.textwidth = 80

vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winborder = "rounded"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 25

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  group = augroup,
  pattern = "*",
  callback = function()
    vim.cmd("setlocal nospell")
  end,
})

vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

vim.opt.showtabline = 1
vim.opt.tabline = ""

-- =========================================
-- KEYMAPS
-- =========================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

map(
  "i",
  "tn",
  "<Esc>",
  { noremap = true, silent = true, desc = "Escape from insert mode" }
)

map("n", "<leader>e", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "netrw" then
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  vim.cmd("Lexplore")
end, { desc = "Toggle file explorer" })

-- =========================================
-- THEME
-- =========================================

vim.opt.background = "dark"
local thm_bg = "#222436"
local thm_fg = "#c8d3f5"
local thm_cyan = "#86e1fc"
local thm_black = "#1b1d2b"
local thm_gray = "#3a3f5a"
local thm_black4 = "#444a73"
local thm_magenta = "#c099ff"
local thm_red = "#ff757f"
local thm_green = "#c3e88d"
local thm_yellow = "#ffc777"
local thm_blue = "#82aaff"
local thm_orange = "#ff9e64"

vim.api.nvim_set_hl(0, "Normal", { fg = thm_fg, bg = thm_bg })
vim.api.nvim_set_hl(0, "CursorLine", { bg = thm_black })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = thm_gray })
vim.api.nvim_set_hl(0, "LineNr", { fg = thm_gray })
vim.api.nvim_set_hl(0, "StatusLine", { fg = thm_fg, bg = thm_gray })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = thm_gray, bg = thm_bg })
vim.api.nvim_set_hl(0, "Visual", { bg = thm_black4 })
vim.api.nvim_set_hl(0, "Search", { fg = thm_bg, bg = thm_yellow })
vim.api.nvim_set_hl(0, "Comment", { fg = thm_red })
vim.api.nvim_set_hl(0, "String", { fg = thm_green })
vim.api.nvim_set_hl(0, "Number", { fg = thm_orange })
vim.api.nvim_set_hl(0, "Function", { fg = thm_blue })
vim.api.nvim_set_hl(0, "Keyword", { fg = thm_magenta })
vim.api.nvim_set_hl(0, "Type", { fg = thm_cyan })

-- =========================================
-- PLUGIN MANAGEMENT
-- =========================================

vim.pack.add({
  {
    name = "nvim-treesitter",
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
  },
  { name = "nvim-autopairs", src = "https://github.com/windwp/nvim-autopairs" },
  { name = "nvim-surround", src = "https://github.com/kylechui/nvim-surround" },
  {
    name = "gitsigns.nvim",
    src = "https://github.com/lewis6991/gitsigns.nvim",
  },
  { name = "nvim-lspconfig", src = "https://github.com/neovim/nvim-lspconfig" },
  { name = "mason.nvim", src = "https://github.com/mason-org/mason.nvim" },
  {
    name = "mason-lspconfig.nvim",
    src = "https://github.com/mason-org/mason-lspconfig.nvim",
  },
  { name = "indent-blankline", src = "https://github.com/lukas-reineke/indent-blankline.nvim" },
  { name = "blink.lib", src="https://github.com/saghen/blink.lib"},
  { name = "blink.cmp", src="https://github.com/saghen/blink.cmp"},
})

-- =========================================
-- PLUGIN SETUP
-- =========================================

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ruff", "ts_ls" },
})

local function safe_setup(name, opts, after)
  local ok, mod = pcall(require, name)
  if not ok then
    return
  end

  if type(mod.setup) == "function" then
    mod.setup(opts or {})
  end

  if type(after) == "function" then
    after(mod)
  end
end

safe_setup("ibl", {
  indent = {
    char = "│",
    highlight = "LineNr",
  },
  scope = {
    enabled = true,
    highlight = "Function",
  },
})

safe_setup("nvim-autopairs")

safe_setup("nvim-surround")

safe_setup("gitsigns", {
  on_attach = function(bufnr)
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        require("gitsigns").nav_hunk("next")
      end
    end)

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        require("gitsigns").nav_hunk("prev")
      end
    end)

    map("n", "<leader>hs", require("gitsigns").stage_hunk)
    map("n", "<leader>hr", require("gitsigns").reset_hunk)

    map("v", "<leader>hs", function()
      require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("v", "<leader>hr", function()
      require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>hS", require("gitsigns").stage_buffer)
    map("n", "<leader>hR", require("gitsigns").reset_buffer)
    map("n", "<leader>hp", require("gitsigns").preview_hunk)
    map("n", "<leader>hi", require("gitsigns").preview_hunk_inline)

    map("n", "<leader>hb", function()
      require("gitsigns").blame_line({ full = true })
    end)

    map("n", "<leader>hd", require("gitsigns").diffthis)

    map("n", "<leader>hD", function()
      require("gitsigns").diffthis("~")
    end)

    map("n", "<leader>hQ", function()
      require("gitsigns").setqflist("all")
    end)

    map("n", "<leader>hq", require("gitsigns").setqflist)

    map("n", "<leader>tb", require("gitsigns").toggle_current_line_blame)
    map("n", "<leader>tw", require("gitsigns").toggle_word_diff)

    map({ "o", "x" }, "ih", require("gitsigns").select_hunk)
  end,
})

require("blink.cmp").setup({
  keymap = {
    preset = "enter",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = {
    implementation = "lua",
  },
})

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- Treesitter setup must be after plugin is loaded by vim.pack
-- Using pcall to handle case where plugin isn't available yet
pcall(function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "javascript" },
    sync_install = false,
  })
end)

-- =========================================
-- LSP CONFIGURATION
-- =========================================

local keymap = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    keymap(
      "n",
      "gD",
      vim.lsp.buf.declaration,
      vim.tbl_extend("force", opts, { desc = "Go to declaration" })
    )
    keymap(
      "n",
      "gd",
      vim.lsp.buf.definition,
      vim.tbl_extend("force", opts, { desc = "Go to definition" })
    )
    keymap(
      "n",
      "gi",
      vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "Go to implementation" })
    )
    keymap(
      "n",
      "gt",
      vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" })
    )
    keymap(
      "n",
      "gR",
      vim.lsp.buf.references,
      vim.tbl_extend("force", opts, { desc = "List references" })
    )

    keymap(
      { "n", "v" },
      "<leader>ca",
      vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code actions" })
    )
    keymap(
      "n",
      "<leader>rn",
      vim.lsp.buf.rename,
      vim.tbl_extend("force", opts, { desc = "Rename" })
    )

    keymap(
      "n",
      "K",
      vim.lsp.buf.hover,
      vim.tbl_extend("force", opts, { desc = "Hover documentation" })
    )

    keymap(
      "n",
      "<leader>d",
      vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "Line diagnostics" })
    )
    keymap("n", "[d", function()
        vim.diagnostic.jump({
            count = -1,
            on_jump = function()
                vim.diagnostic.open_float(nil, { focus = true })
            end,
        })
    end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))

    keymap("n", "]d", function()
        vim.diagnostic.jump({
            count = 1,
            on_jump = function()
                vim.diagnostic.open_float(nil, { focus = true })
            end,
        })
    end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    keymap(
      "n",
      "<leader>rs",
      "<cmd>LspRestart<CR>",
      vim.tbl_extend("force", opts, { desc = "Restart LSP" })
    )
  end,
})

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

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  filetypes = { "lua" },
  root_dir = function(fname)
    if type(fname) ~= "string" then
      return nil
    end
    local found = vim.fs.find(
      { "init.lua", ".git" },
      { upward = true, path = fname }
    )
    if #found == 0 then
      return nil
    end
    return vim.fs.dirname(found[1])
  end,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
        ignoreDir = { ".git", "node_modules", ".cache", ".local" },
        maxPreload = 0,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

vim.lsp.config("pyright", {
  capabilities = capabilities,
  filetypes = { "python" },
})

vim.lsp.config("ruff_lsp", {
  capabilities = capabilities,
  filetypes = { "python" },
  init_options = {
    settings = {
      lineLength = 80,
    },
  },
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },
})
