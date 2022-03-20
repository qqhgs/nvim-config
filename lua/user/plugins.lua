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
  use "lewis6991/impatient.nvim"
  use "nathom/filetype.nvim"
  use "nvim-lua/plenary.nvim"

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
    opt = true,
    setup = [[require"user.utils".defer"indent-blankline.nvim"]],
    config = [[require"user.modules.indentline"]],
  }
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    setup = [[require"user.utils".defer"telescope.nvim"]],
    config = [[require"user.modules.telescope"]],
    requires = "project.nvim",
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

  use {
    "rafamadriz/friendly-snippets",
    opt = true,
    setup = [[require"user.utils".defer"friendly-snippets"]],
  }
  use { "hrsh7th/nvim-cmp", config = [[require"user.modules.cmp"]], after = "friendly-snippets" }
  use { "L3MON4D3/LuaSnip", wants = "friendly-snippets", after = "nvim-cmp" }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" }
  use { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path", after = "cmp-buffer" }
  use { "hrsh7th/cmp-cmdline", after = "cmp-path" }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp-cmdline" }

  use {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      require("user.utils").defer "nvim-lspconfig"
    end,
    requires = "williamboman/nvim-lsp-installer",
    config = [[require"user.modules.lsp"]],
  }
  use { "jose-elias-alvarez/null-ls.nvim", config = [[require"user.modules.null_ls"]], after = "nvim-lspconfig" }
  use { "williamboman/nvim-lsp-installer", opt = "true" }
  use { "ray-x/lsp_signature.nvim", config = [[require"user.modules.signature"]], after = "nvim-lspconfig" }

  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    event = "BufRead",
    config = [[require"user.modules.gitsigns"]],
  }
  use {
    "folke/which-key.nvim",
    opt = true,
    setup = [[require"user.utils".defer"which-key.nvim"]],
    config = [[require"user.modules.whichkey"]],
  }
  use { "numToStr/Comment.nvim", config = [[require"user.modules.comment"]], after = "nvim-treesitter" }
  use {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = [[require"user.modules.autopairs"]],
  }
  use {
    "akinsho/toggleterm.nvim",
    opt = true,
    setup = [[require"user.utils".defer"toggleterm.nvim"]],
    config = [[require"user.modules.toggleterm"]],
  }
  use { "folke/persistence.nvim", after = "alpha-nvim", config = [[require"persistence".setup()]] }
  use { "norcalli/nvim-colorizer.lua", config = [[require"user.modules.colorizer"]], opt = true, event = "BufRead" }

  use { "dstein64/vim-startuptime", opt = true, setup = [[require"user.utils".defer"vim-startuptime"]] }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
