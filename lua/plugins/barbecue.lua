local icons = require("const.icons")

return {
  "utilyre/barbecue.nvim",
  -- enabled = false,
  event = "BufRead",
  branch = "fix/E36",
  -- name = "barbecue",
  -- version = "*",
  -- event = "VeryLazy",
  -- lazy = false,
  -- dependencies = {
  --   "SmiteshP/nvim-navic",
  --   "nvim-tree/nvim-web-devicons", -- optional dependency
  -- },
  -- opts = {
  --   exclude_filetypes = { "toggleterm" },
  --   show_modified = true,
  --   symbols = {
  --     separator = icons.ui.ChevronRight,
  --   },
  -- },
  config = function()
    require("barbecue").setup({
      exclude_filetypes = { "toggleterm", "DressingInput" },
      show_modified = false,
      symbols = {
        separator = icons.ui.ChevronRight,
      },
    })
  end,
}
