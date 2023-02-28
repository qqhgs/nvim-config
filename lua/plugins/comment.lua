return {
  { "JoosepAlviste/nvim-ts-context-commentstring" },
  {
    "numToStr/Comment.nvim",
    -- event = "VeryLazy",
    opts = {
      ignore = "^$",
      hooks = {
        pre = function() require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook() end,
      },
    },
    keys = function()
      local api = require("Comment.api")
      return {
        { "<C-_>", api.call("toggle.linewise.current", "g@$"), mode = "n", expr = true },
        { "<C-_>", api.call("toggle.linewise", "g@$"), mode = "x", expr = true },
      }
    end,
  },
}
