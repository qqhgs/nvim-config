return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  opts = function()
    return {
      view = {
        width = 35,
          -- stylua: ignore
          mappings = {
            list = {
              { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
              { key = "h", action = "close_node" },
              { key = "v", action = "vsplit" },
              { key = "C", action = "cd" },
              { key = "gtf", action = "telescope_find_files", action_cb = require("util").start_telescope("find_files") },
              { key = "gtg", action = "telescope_live_grep", action_cb = require("util").start_telescope("live_grep") },
            },
          },
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      git = {
        ignore = false,
        timeout = 200,
      },
      filters = {
        custom = { "node_modules", "\\.cache" },
      },
    }
  end,
  keys = {
    { "<C-n>", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
    -- { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  },
}
