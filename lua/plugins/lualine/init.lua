return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local components = require("plugins.lualine.components")

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "lazy", "alpha" } },
        component_separators = "",
        section_separators = "",
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          components.branch,
          { "diff" },
          components.lsp,
          { "diagnostics" },
          -- { "filename", path = 1, symbols = { modified = " ", readonly = "", unnamed = "" } },
          { "mode", fmt = function(str) return "--" .. str .. "--" end },
        },
        lualine_x = {
          { components.location },
          { "encoding" },
          { "filetype" },
          components.treesitter,
        },
        lualine_y = {
          -- { "progress", separator = " ", padding = { left = 1, right = 0 } },
          -- { "location", padding = { left = 0, right = 1 } },
          -- { "filetype", icon_only = false, separator = "", padding = { left = 1, right = 1 } },
        },
        lualine_z = {
          -- { "encoding" },
        },
      },
      extensions = { "nvim-tree", "toggleterm", "symbols-outline", "quickfix" },
    }
  end,
}
