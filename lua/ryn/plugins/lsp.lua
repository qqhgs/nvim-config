local M = {}

M.config = function()
  Ryn.builtins.lsp = {
    sign = {
      error = "",
      warn = "",
      hint = "",
      info = "",
    },
    keymaps = {
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
    },
    config = {
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
    },
  }
end

M.setup = function()
  local sign = Ryn.builtins.lsp.sign
  vim.fn.sign_define("DiagnosticSignError", { text = sign.error, texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = sign.warn, texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignHint", { text = sign.hint, texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignInfo", { text = sign.info, texthl = "DiagnosticSignError" })

  vim.diagnostic.config(Ryn.builtins.lsp.config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
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
    for lhs, rhs in pairs(Ryn.builtins.lsp.keymaps) do
      vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
    end
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function on_attach(client, bufnr)
    if Ryn.lsp_settings ~= nil then
      for key, callback in pairs(Ryn.lsp_settings.on_attach or {}) do
        if client.name == key then
          callback(client)
        end
      end
    end
    keymaps(bufnr)
    highlight_document(client)
  end

  require("nvim-lsp-installer").on_server_ready(function(server)
    local opts = { on_attach = on_attach, capabilities = capabilities }

    if Ryn.lsp_settings ~= nil then
      for server_name, server_config in pairs(Ryn.lsp_settings.servers or {}) do
        if server.name == server_name then
          opts = vim.tbl_deep_extend("force", server_config, opts)
        end
      end
    end

    server:setup(opts)
  end)
end

return M
