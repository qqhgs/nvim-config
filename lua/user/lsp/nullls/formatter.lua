local M = {}

local nls_sources = require "null-ls.sources"

local method = require("null-ls").methods.FORMATTING

function M.format()
  vim.lsp.buf.format {
    async = true,
    filter = function(client)
      return client.name == "null-ls"
    end,
  }
end

function M.setup(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

  local enable = false

  if M.has_formatter(filetype) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end
  if not enable then
    return
  end

  client.server_capabilities.documentFormattingProvder = enable
  client.server_capabilities.documentRangeFormattingProvider = enable
end

function M.has_formatter(filetype)
  local available = nls_sources.get_available(filetype, method)
  return #available > 0
end

return M
