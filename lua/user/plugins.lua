local util = require "user.util"
local fn = vim.fn

local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  print "Cloning packer.nvim..."
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }

  local present, packer = pcall(require, "packer")
  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. install_path .. "\n" .. packer)
  end
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

util.keymap("n", "<Leader>ps", ":PackerSync<CR>")

local _, packer = pcall(require, "packer")
local _, packer_util = pcall(require, "packer.util")

packer.init {
  display = {
    open_fn = function()
      return packer_util.float { border = "rounded" }
    end,
  },
  profile = {
    enable = true,
    threshold = 0.0001,
  },
  git = {
    clone_timeout = 300,
    subcommands = {
      update = "pull --rebase",
    },
  },
  auto_clean = true,
  compile_on_sync = true,
  compile_path = vim.fn.stdpath "config" .. "/lua/user/compiled.lua",
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "lewis6991/impatient.nvim"
  use "nvim-lua/plenary.nvim"
  use "antoinemadec/FixCursorHold.nvim"

  use(require("user.modules.rynkai").theme_config "~/workspaces/nvim/rynkai.nvim")

  use { "kyazdani42/nvim-web-devicons", after = "colorscheme" }

  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "user.modules.bufferline"
    end,
  }

  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "user.modules.lualine"
    end,
  }

  use {
    "nvim-neo-tree/neo-tree.nvim",
    after = "nvim-web-devicons",
    branch = "v2.x",
    requires = {
      "MunifTanjim/nui.nvim",
    },
    setup = function()
      require("user.keymaps").set("n", "\\", "<cmd>Neotree reveal toggle<cr>")
      require("user.keymaps").set("n", "<C-n>", "<cmd>Neotree reveal toggle<cr>")
    end,
    config = function()
      require "user.modules.neotree"
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    config = [[require"user.modules.indentline"]],
  }

  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    cmd = { "Telescope" },
    setup = function()
      require("user.modules.telescope").keymaps()
    end,
    config = function()
      require("user.modules.telescope").setup()
    end,
    wants = {
      "plenary.nvim",
      "telescope-ui-select.nvim",
      "telescope-fzy-native.nvim",
      "telescope-media-files.nvim",
      "project.nvim",
      "which-key.nvim",
    },
    -- module = { "telescope", "telescope.builtin" },
    -- keys = { "<C-p>", "\\", "<Leader>f" },
    -- config = [[require"config.telescope"]],
    requires = {
      "nvim-telescope/telescope-fzy-native.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-media-files.nvim",
      {
        "ahmedkhalf/project.nvim",
        config = function()
          require "user.modules.project"
        end,
      },
    },
  }

  use {
    "goolord/alpha-nvim",
    config = function()
      require "user.modules.alpha"
    end,
  }

  use {
    "nvim-treesitter/nvim-treesitter",
    opt = true,
    event = "BufReadPre",
    run = ":TSUpdate",
    config = function()
      require "user.modules.treesitter"
    end,
    requires = {
      { "windwp/nvim-ts-autotag", event = "InsertEnter" },
      { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
      { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
      { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
    },
  }

  -- completion
  use {
    "hrsh7th/nvim-cmp",
    opt = true,
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
      require "user.modules.cmp"
    end,
    wants = { "LuaSnip" },
    requires = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
  }

  use { "williamboman/nvim-lsp-installer", opt = true, setup = [[require"user.util".defer"nvim-lsp-installer"]] }
  use { "neovim/nvim-lspconfig", after = "nvim-lsp-installer", config = [[require"user.modules.lsp"]] }
  use { "jose-elias-alvarez/null-ls.nvim", config = [[require"user.modules.null_ls"]], after = "nvim-lspconfig" }
  use { "ray-x/lsp_signature.nvim", config = [[require"user.modules.signature"]], after = "null-ls.nvim" }

  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    event = "BufRead",
    config = [[require"user.modules.gitsigns"]],
  }
  use {
    "folke/which-key.nvim",
    config = [[require"user.modules.whichkey"]],
  }
  use {
    "numToStr/Comment.nvim",
    after = "nvim-treesitter",
    config = function()
      require "user.modules.comment"
    end,
  }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opt = true,
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = [[require"user.modules.autopairs"]],
  }
  use {
    "akinsho/toggleterm.nvim",
    opt = true,
    setup = [[require"user.util".defer"toggleterm.nvim"]],
    config = [[require"user.modules.toggleterm"]],
  }

  use {
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    wants = { "which-key.nvim" },
    config = function()
      require("user.config.session")
    end,
  }
  use { "norcalli/nvim-colorizer.lua", config = [[require"user.modules.colorizer"]], event = "BufRead" }

  use {
    "AndrewRadev/splitjoin.vim",
    event = "BufRead",
  }

  use {
    "machakann/vim-sandwich",
    event = "BufRead",
  }
  use {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = [[require("user.modules.hop")]],
  }
  use {
    "andymass/vim-matchup",
    event = "BufRead",
  }

  use { "simrat39/symbols-outline.nvim", config = [[require"user.modules.symbols_outline".setup()]] }

  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    setup = function()
      require("user.modules.whichkey").registers {
        t = { ":StartupTime<CR>", "StartupTime" },
      }
      -- vim.keymap.set("n", "<C-r>", "q<cmd>StartupTime<cr>", )
    end,
  }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
