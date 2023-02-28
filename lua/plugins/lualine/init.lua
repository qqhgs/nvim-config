return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(plugin)
    local function fg(name)
      return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    local components = require("plugins.lualine.components")

    return {
      options = {
        theme = "auto",
        globalstatus = true,
        disabled_filetypes = { statusline = { "lazy", "alpha" }, winbar = { "NvimTree", "alpha", "toggleterm" } },
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
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          components.modicon,
          components.breadcrumb,
          components.navic,
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_c = { components.breadcrumb },
      },
      extensions = { "nvim-tree", "toggleterm", "symbols-outline", "quickfix" },
    }
  end,
}
