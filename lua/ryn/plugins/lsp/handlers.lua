local M = {}

M.setup = function()
  local function set_sign(name, text)
    vim.fn.sign_define(name, { text = text, texthl = name })
  end
  set_sign("DiagnosticSignError", "")
  set_sign("DiagnosticSignWarn", "")
  set_sign("DiagnosticSignHint", "")
  set_sign("DiagnosticSignInfo", "")

  vim.diagnostic.config {
    virtual_text = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

local function highlight_document(client)
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function keymaps(bufnr)
  local keybindings = {
    ["<Leader>la"] = ":lua vim.lsp.buf.code_action()<CR>",
    ["<Leader>lc"] = ":lua vim.lsp.buf.references()<CR>",
    ["<Leader>ld"] = ":lua vim.lsp.buf.definition()<CR>",
    ["<Leader>le"] = ":lua vim.lsp.buf.declaration()<CR>",
    ["<Leader>lf"] = ":lua vim.lsp.buf.formatting()<CR>",
    ["<Leader>lF"] = ":LspToggleAutoFormat<CR>",
    ["<Leader>lh"] = ":lua vim.lsp.buf.hover()<CR>",
    ["<Leader>li"] = ":LspInfo<CR>",
    ["<Leader>lr"] = ":lua vim.lsp.buf.rename()<CR>",
    ["<Leader>lq"] = ":lua vim.diagnostic.setloclist()<CR>",
  }
  for lhs, rhs in pairs(keybindings) do
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
  end
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.resolved_capabilities.document_formatting = false
  end
  keymaps(bufnr)
  highlight_document(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
