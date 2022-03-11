return {

  { "nvim-lua/plenary.nvim" },
  { "lewis6991/impatient.nvim" },
  { "nathom/filetype.nvim" },
  { "antoinemadec/FixCursorHold.nvim" }, -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

  { "wbthomason/packer.nvim", event = "VimEnter" },

  { "qqhgs/rynkai.nvim", after = "packer.nvim", config = [[require"ryn.plugins.rynkai".setup()]] },

  { "kyazdani42/nvim-web-devicons", after = "rynkai.nvim" },

  { "nvim-lualine/lualine.nvim", after = "nvim-web-devicons", config = [[require"ryn.plugins.statusline".setup()]] },

  { "akinsho/bufferline.nvim", after = "nvim-web-devicons", config = [[require"ryn.plugins.bufferline".setup()]] },

  { "kyazdani42/nvim-tree.lua", after = "nvim-web-devicons", config = [[require"ryn.plugins.nvimtree".setup()]] },

  { "lukas-reineke/indent-blankline.nvim", event = "BufRead", config = [[require"ryn.plugins.indentline".setup()]] },

  { "nvim-telescope/telescope.nvim", config = [[require"ryn.plugins.telescope".setup()]] },
  { "ahmedkhalf/project.nvim", config = [[require"ryn.plugins.project".setup()]] },

  { "goolord/alpha-nvim", config = [[require"ryn.plugins.alpha".setup()]] },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    config = [[require"ryn.plugins.treesitter".setup()]],
  },

  { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

  {
    "hrsh7th/nvim-cmp",
    config = [[require"ryn.plugins.cmp".setup()]],
    requires = {
      "L3MON4D3/LuaSnip",
    },
  },
  { "L3MON4D3/LuaSnip", config = [[require"ryn.plugins.luasnip".setup()]] },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },

  { "neovim/nvim-lspconfig", config = [[require"ryn.plugins.lsp".setup()]] },
  { "jose-elias-alvarez/null-ls.nvim", config = [[require"ryn.plugins.null_ls".setup()]] },
  { "williamboman/nvim-lsp-installer" },

  { "lewis6991/gitsigns.nvim", config = [[require"ryn.plugins.gitsigns".setup()]] },
  { "folke/which-key.nvim", config = [[require"ryn.plugins.whichkey".setup()]] },
  { "numToStr/Comment.nvim", config = [[require"ryn.plugins.comment".setup()]] },
  { "windwp/nvim-autopairs", config = [[require"ryn.plugins.autopairs".setup()]] },
  { "akinsho/toggleterm.nvim", config = [[require"ryn.plugins.toggleterm".setup()]] },
  { "folke/persistence.nvim", config = [[require"persistence".setup()]] },
}
