local config_file = vim.fn.stdpath "config" .. "/lua/ryn/user/init.lua"
local cmp = require "cmp"

vim.api.nvim_set_keymap("n", "<F6>", ":terminal lazygit<CR>", { noremap = true, silent = false })

return {
  keymaps = {
    mode = {
      normal_mode = {
        -- Session
        ["<Leader>qs"] = ":lua require('persistence').load()<CR>",
        ["<Leader>ql"] = ":lua require('persistence').load({ last = true })<CR>",
        ["<Leader>qd"] = ":lua require('persistence').stop()<CR>",
      },
    },
  },
  builtins = {
    rynkai = {
      theme = "catppuccin",
      config_file = config_file,
    },
    cmp = {
      sources = {
        { name = "nvim_lua" },
        { name = "path" },
        { name = "cmdline" },
      },
      source_names = {
        nvim_lua = "[Nvim]",
        path = "[Path]",
        cmdline = "[CMD]",
      },
      fn = function()
        cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
        cmp.setup.cmdline(":", { sources = { { name = "cmdline" } } })
      end,
    },
    treesitter = {
      ensure_installed = {
        -- "html",
        -- "css",
        -- "scss",
        -- "c",
        -- "go",
        -- "json",
        -- "javascript",
        -- "svelte",
        -- "php",
        -- "lua",
        -- "vim",
        -- "bash",
        -- "markdown",
      },
      autotag = {
        enable = true,
      },
    },
    toggleterm = {
      callback = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
        function _LAZYGIT_TOGGLE()
          lazygit:toggle()
        end
      end,
    },
  },
  plugins = {
    "rafamadriz/friendly-snippets",
    "folke/persistence.nvim",
    "goolord/alpha-nvim",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
    "windwp/nvim-ts-autotag",
    "norcalli/nvim-colorizer.lua",
    "dstein64/vim-startuptime",
  },
}
