local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  require("user.lsp.nullls.formatter").setup(client, bufnr)
  -- require("lsp_signature").on_attach(require("config.signature").config, bufnr)

  local navic_present, navic = pcall(require, "nvim-navic")
  if navic_present and client.server_capabilities.documentSymbolProvider then
    navic.setup()
    navic.attach(client, bufnr)
  end

  local renamer_present, renamer = pcall(require, "renamer")
  if renamer_present then
    renamer.setup()
  end

  require("user.lsp.keymaps").setup(bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.documentFormattingProvider = true
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- for nvim-cmp

local server_settings = function(server_name)
  local servers = require "user.lsp.servers"
  local server_opts = { on_attach = on_attach, capabilities = capabilities }
  local opts = vim.tbl_deep_extend("force", server_opts, servers[server_name])
  require("lspconfig")[server_name].setup(opts)
end

require "user.lsp.handlers"

local server_opts = {
  on_attach = on_attach,
  capabilities = capabilities,
}

require("user.lsp.nullls").setup(server_opts)

local servers = require "user.lsp.servers"
require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = vim.tbl_keys(servers),
}
local lspconfig = require "lspconfig"

require("mason-lspconfig").setup_handlers {
  function(server_name)
    local opts = vim.tbl_deep_extend("force", server_opts, servers[server_name] or {})
    lspconfig[server_name].setup(opts)
  end,
  ["sumneko_lua"] = server_settings "sumneko_lua",
}
