local M = {}

M.config = function()
  Ryn.builtins.bufferline = {
    options = {
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match "error" and " " or " "
        return " " .. icon .. count .. " "
      end,
      separator_style = { "", "" },
      offsets = {
        {
          filetype = "NvimTree",
          padding = 1,
        },
      },
      modified_icon = " ",
      always_show_bufferline = false,
    },
  }
end

M.setup = function()
  require("bufferline").setup(Ryn.builtins.bufferline)
end

return M
