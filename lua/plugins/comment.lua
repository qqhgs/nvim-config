return {
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "numToStr/Comment.nvim",
    opts = {
      ignore = "^$",
      hooks = {
        pre = function() require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook() end,
      },
    },
    keys = {
      {
        "<C-_>",
        function()
          return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)"
            or "<Plug>(comment_toggle_linewise_count)"
        end,
        mode = "n",
        expr = true,
      },
      { "<C-_>", "<Plug>(comment_toggle_linewise_visual)", mode = "x" },
    },
  },
}
