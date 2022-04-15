local util = require"user.util"
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
  use "nvim-lua/plenary.nvim"

  use {
    -- "qqhgs/rynkai.nvim",
    "~/project/nvim/rynkai.nvim",
    event = "VimEnter",
    config = function()
      require "user.modules.rynkai"
    end,
  }

  use { "kyazdani42/nvim-web-devicons", after = "rynkai.nvim" }

  use {
    "akinsho/bufferline.nvim",
		commit = "50e1bfe6f2c474c0a6e8171606b001f3b17ddeb2",
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
    config = function()
      require "user.modules.neotree"
    end,
  }

  use {
    "lukas-reineke/indent-blankline.nvim",
    opt = true,
    setup = [[require"user.util".defer"indent-blankline.nvim"]],
    config = [[require"user.modules.indentline"]],
  }
  use {
    "nvim-telescope/telescope.nvim",
    opt = true,
    setup = [[require"user.util".defer"telescope.nvim"]],
    config = [[require"user.modules.telescope"]],
  }
	use {
		"nvim-telescope/telescope-ui-select.nvim",
		after = "telescope.nvim",
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
    requires = {
      "nathom/filetype.nvim",
    },
    run = ":TSUpdate",
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }
  use { "windwp/nvim-ts-autotag", after = "nvim-treesitter" }

  use {
    "hrsh7th/nvim-cmp",
    config = [[require"user.modules.cmp"]],
    -- event = { "InsertEnter", "CmdlineEnter" },
    opt = true,
		commit = "dd6e4d96f9e376c87302fa5414556aa6269bf997",
    setup = [[require"user.util".defer"nvim-cmp"]],
  }
  use { "L3MON4D3/LuaSnip", after = "nvim-cmp", config = [[require"user.modules.luasnip"]] }
  use { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }
  use { "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" }
  use { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" }
  use { "hrsh7th/cmp-path", after = "cmp-buffer" }
  use { "hrsh7th/cmp-cmdline", after = "cmp-path" }
  use { "hrsh7th/cmp-nvim-lua", after = "cmp-cmdline" }

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
    opt = true,
    setup = [[require"user.util".defer"which-key.nvim"]],
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
    config = [[require"user.modules.autopairs"]],
  }
  use {
    "akinsho/toggleterm.nvim",
		commit = "e62008fe5879eaecb105eb81e393f87d4607164c",
    opt = true,
    setup = [[require"user.util".defer"toggleterm.nvim"]],
    config = [[require"user.modules.toggleterm"]],
  }

  use { "folke/persistence.nvim", after = "alpha-nvim", config = [[require"persistence".setup()]] }
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

  use { "dstein64/vim-startuptime", cmd = "StartupTime" }

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
