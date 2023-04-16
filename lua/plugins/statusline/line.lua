local conditions = require("heirline.conditions")
-- local utils = require("heirline.utils")
local components = require("plugins.statusline.components")

local M = {}

M.SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      filetype = { "NvimTree", "toggleterm", "Outline" },
    })
  end,
  fallthrough = false,
  components.Toggleterm,
  components.NvimTree,
  components.Outline,
}

M.DefaultStatusline = {
  components.Vimode,
  components.Git,
  components.Align,
  components.Diagnostics,
  components.LSP,
  components.Space,
  components.Treesitter,
  components.FileEncoding,
  components.Space,
  components.FileType,
  components.Space,
  components.Ruler,
}

M.DefaultWinbar = {
  components.Breadcrumbs,
  components.Align,
  components.SearchCount,
  components.Space,
  components.Cwd,
}

M.Statuscolumn = vim.fn.has("nvim-0.9") == 1
    and {
      components.Signcolumn,
      components.Numbercolumn,
      components.Align,
      components.Foldcolumn,
    }
  or nil

return M
