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
  vim.cmd [[packadd packer.nvim]]
  local present, packer = pcall(require, "packer")
  if present then
    print "Packer cloned successfully."
    print "Close and reopen Neovim."
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

packer.init {
  git = {
    clone_timeout = 300,
    subcommands = {
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
  profile = {
    enable = true,
  },
  auto_clean = true,
  compile_on_sync = true,
  compile_path = vim.fn.stdpath "config" .. "/lua/user/compiled.lua",
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/plenary.nvim"
  use "lewis6991/impatient.nvim"
  use "nathom/filetype.nvim"

  use {
    "qqhgs/rynkai.nvim",
    -- "~/project/nvim/rynkai.nvim",
    event = "VimEnter",
    config = function()
      require "user.modules.rynkai"
    end,
  }

  use { "kyazdani42/nvim-web-devicons", after = "rynkai.nvim" }

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
      require "user.modules.statusline"
    end,
  }

  use {
    "kyazdani42/nvim-tree.lua",
    after = "nvim-web-devicons",
    config = function()
      require "user.modules.nvimtree"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require "user.modules.indentline"
    end,
  }
  use {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require "user.modules.telescope"
    end,
  }
  use {
    "ahmedkhalf/project.nvim",
    after = "telescope.nvim",
    config = function()
      require "user.modules.project"
    end,
  }
  use {
    "goolord/alpha-nvim",
    config = function()
      require "user.modules.alpha"
    end,
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require "user.modules.treesitter"
    end,
    run = ":TSUpdate",
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }
  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }

  use { "rafamadriz/friendly-snippets", event = "InsertEnter" }
  use { "hrsh7th/nvim-cmp", config = [[require"user.modules.cmp"]], after = "friendly-snippets" }
  use { "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp" }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" }
  use { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path", after = "cmp-buffer" }
  use { "hrsh7th/cmp-cmdline", after = "cmp-path" }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp-cmdline" }

  use { "neovim/nvim-lspconfig", config = [[require"user.modules.lsp"]] }
  use { "jose-elias-alvarez/null-ls.nvim", config = [[require"user.modules.null_ls"]] }
  use "williamboman/nvim-lsp-installer"

  use { "lewis6991/gitsigns.nvim", config = [[require"user.modules.gitsigns"]] }
  use { "folke/which-key.nvim", config = [[require"user.modules.whichkey"]] }
  use { "numToStr/Comment.nvim", config = [[require"user.modules.comment"]] }
  use { "windwp/nvim-autopairs", config = [[require"user.modules.autopairs"]] }
  use { "akinsho/toggleterm.nvim", config = [[require"user.modules.toggleterm"]] }
  use "folke/persistence.nvim"
  use { "norcalli/nvim-colorizer.lua", config = [[require"user.modules.colorizer"]] }

  use "dstein64/vim-startuptime"

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
