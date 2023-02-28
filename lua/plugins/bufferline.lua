return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
  },
  opts = {
    options = {
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = "",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
}
