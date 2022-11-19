local present, _ = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
  -- delete the old packer install if one exists
  vim.fn.delete(packer_path, "rf")
  -- clone packer
  print "Cloning Packer...\n"
  vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    packer_path,
  }
  print "Initializing Packer...\n"
  -- add packer and try loading it
  vim.cmd.packadd "packer.nvim"
  present, _ = pcall(require, "packer")
  -- if packer didn't load, print error
  if not present then
    vim.api.nvim_err_writeln("Failed to load packer at:" .. packer_path)
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

vim.keymap.set("n", "<Leader>ps", ":PackerSync<CR>", { noremap = true, silent = true })

local packer_util = require "packer.util"

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

require("user.modules.whichkey").registers {
  p = {
    name = "Packer",
    a = { ":PackerClean<CR>", "Clean" },
    c = { ":PackerCompile<CR>", "Compile (Re)" },
    i = { ":PackerInstall<CR>", "Install" },
    u = { ":PackerUpdate<CR>", "Update" },
    s = { ":PackerSync<CR>", "Sync" },
    x = { ":lua require('maco.core.packer').snapshot()<CR>", "Snapshot" },
    S = { ":PackerStatus<CR>", "Status" },
    p = { ":PackerProfile<CR>", "Profile" },
  },
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

	-- Treesitter
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

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    opt = true,
    event = { "BufReadPre" },
    wants = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "cmp-nvim-lsp",
      "null-ls.nvim",
      "nvim-navic",
      "renamer.nvim",
    },
    config = function()
      require "user.lsp"
    end,
    requires = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      {
        "SmiteshP/nvim-navic",
        config = [[require"user.config.navic"]],
      },

      {
        "filipdutescu/renamer.nvim",
        config = [[require"user.config.renamer"]],
      },
    },
  }

  use {
    "lewis6991/gitsigns.nvim",
    opt = true,
    event = "BufRead",
    config = [[require"user.modules.gitsigns"]],
  }
  use {
    "folke/which-key.nvim",
    config = [[require"user.modules.whichkey".setup()]],
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
      require "user.config.session"
    end,
  }
  use { "norcalli/nvim-colorizer.lua", config = [[require"user.modules.colorizer"]], event = "BufRead" }
  use {
    "AndrewRadev/splitjoin.vim",
    event = "BufRead",
  }

  -- better surround
  use { "tpope/vim-surround", event = "BufReadPre" }
  use { "Matt-A-Bennett/vim-surround-funk", event = "BufReadPre" }

  use {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = [[require("user.modules.hop")]],
  }
  use {
    "andymass/vim-matchup",
    event = "BufRead",
  }

  -- buffer
  use {
    "kazhala/close-buffers.nvim",
    cmd = { "BDelete", "BWipeout" },
    setup = [[require"user.config.closebuffer"]],
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
end)
