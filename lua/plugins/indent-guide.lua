return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { char = "│" },
    -- char = "▏",
    -- char = "│",
    -- filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
    -- show_trailing_blankline_indent = false,
    -- show_current_context = true,
  },
}
