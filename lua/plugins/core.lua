local icons = require("const.icons")

return {

  { "folke/lazy.nvim", lazy = false },
  "williamboman/mason-lspconfig.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons",

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      vim.opt.timeoutlen = 100
      local wk = require("which-key")
      wk.setup({
        icons = { group = vim.g.icons_enabled and "" or "+" },
        disable = { filetypes = { "TelescopePrompt" } },
      })

      local keymaps = {
        mode = { "n", "v" },
        ["<leader>b"] = { name = "Buffer" },
        -- ["<leader>c"] = { name = "Code" },
        ["<leader>c"] = { name = icons.ui.Gear .. " LSP" },
        ["<leader>g"] = { name = icons.git.Git .. " Git" },
        ["<leader>gh"] = { desc = "Hunks" },
        ["<leader>q"] = { name = "Session" },
        ["<leader>s"] = { name = "Search" },
        ["<leader>i"] = { desc = "Tab" },
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
    event = "VeryLazy",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      { "gM", "<cmd>TSJToggle<cr>", desc = "Toggle node under cursor" },
      { "gS", "<cmd>TSJSplit<cr>", desc = "Split node under cursor" },
      { "gJ", "<cmd>TSJJoin<cr>", desc = "Join node under cursor" },
    },
    config = function()
      require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 1000,
      })
    end,
  },
}
