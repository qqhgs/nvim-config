return {

  { "folke/lazy.nvim", lazy = false },
  "williamboman/mason-lspconfig.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  -- {
  --   dir = "~/workspaces/nvim/mayu.nvim",
  --   lazy = false,
  --   config = function() require("mayu").setup() end,
  -- },

  {
    "folke/which-key.nvim",
    lazy = false,
    config = function()
      vim.opt.timeoutlen = 100
      local wk = require("which-key")
      wk.setup()

      local keymaps = {
        mode = { "n", "v" },
        ["<leader>b"] = { name = "Buffer" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>g"] = { name = "Git" },
        ["<leader>gh"] = { name = "Hunks" },
        ["<leader>q"] = { name = "Session" },
        ["<leader>s"] = { name = "Search" },
        ["<leader>t"] = { name = "Tools" },
        ["<leader>u"] = { name = "UI" },
        ["<leader>x"] = { name = "Diagnostics/quickfix" },
      }
      wk.register(keymaps)
    end,
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
}
