local plugins = {

  "nvim-lua/plenary.nvim",
  "lewis6991/impatient.nvim",
  "nathom/filetype.nvim",

  {
    "wbthomason/packer.nvim",
    event = "VimEnter",
  },

  {
    "qqhgs/rynkai.nvim",
    after = "packer.nvim",
    config = [[require("config.colorscheme")]],
  },

  {
    "kyazdani42/nvim-web-devicons",
    after = "rynkai.nvim",
  },

  {
    "goolord/alpha-nvim",
    config = [[require'config.alpha']],
  },

  {
    "nvim-telescope/telescope.nvim",
    -- module = "telescope",
    -- cmd = "Telescope",
    opt = true,
    setup = function()
      vim.defer_fn(function()
        require("packer").loader "telescope.nvim"
      end, 0)
    end,
    config = [[require"config.telescope"]],
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    after = "telescope.nvim",
    setup = function()
      require("telescope").load_extension "ui-select"
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    after = "telescope-ui-select.nvim",
    config = [[require'config.project']],
  },

  {
    "Shatur/neovim-session-manager",
    after = "project.nvim",
    config = [[require'config.session-manager']],
  },

  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = [[require"config.nvimtree"]],
  },

  {
    "nvim-lualine/lualine.nvim",
    after = "nvim-web-devicons",
    config = [[require"config.lualine"]],
  },

  {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = [[require"config.bufferline"]],
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = [[require("config.treesitter")]],
    run = ":TSUpdate",
    requires = {
      { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
      { "windwp/nvim-ts-autotag", after = "nvim-ts-context-commentstring" },
    },
  },

  { "rafamadriz/friendly-snippets", event = "InsertEnter,CmdlineEnter *" },
  {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    requires = {
      {
        "L3MON4D3/LuaSnip",
        wants = "friendly-snippets",
        after = "nvim-cmp",
        config = [[require("config.luasnip")]],
      },
      { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
      { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
      { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
      { "hrsh7th/cmp-path", after = "cmp-buffer" },
      { "hrsh7th/cmp-cmdline", after = "cmp-path" },
    },
    config = [[require("config.cmp")]],
  },

  {
    "neovim/nvim-lspconfig",
    opt = true,
    setup = function()
      vim.defer_fn(function()
        require("packer").loader "nvim-lspconfig"
      end, 0)
    end,
    config = [[require("config.lsp")]],
  },
  { "williamboman/nvim-lsp-installer", after = "nvim-lspconfig" }, --- automate lsp configuration steps
  { "jose-elias-alvarez/null-ls.nvim", after = "nvim-lsp-installer", config = [[require"config.lsp.null-ls"]] }, --- Formatting and linting
  -- { "ray-x/lsp_signature.nvim", after = "null-ls.nvim", config = [[require"config.lsp.signature"]] },

  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    setup = function()
      vim.defer_fn(function()
        require("packer").loader "gitsigns.nvim"
      end, 0)
    end,
    config = [[require("config.gitsigns")]],
  },

  {
    "folke/which-key.nvim",
    opt = true,
    setup = function()
      vim.defer_fn(function()
        require("packer").loader "which-key.nvim"
      end, 0)
    end,
    config = [[require'config.which-key']],
  },

  --- Misc
  { "lukas-reineke/indent-blankline.nvim", event = "BufRead", config = [[require("config.indentline")]] }, --- Indent line
  { "numToStr/Comment.nvim", module = "Comment", config = [[require('config.comment')]] }, --- Auto comment base on filetype
  { "windwp/nvim-autopairs", after = "nvim-cmp", config = [[require("config.autopairs")]] }, --- Autopair some characters
  { "akinsho/toggleterm.nvim", after = "nvim-web-devicons", config = [[require'config.toggleterm']] },
  { "norcalli/nvim-colorizer.lua", event = "BufRead", config = [[require'config.colorizer']] },

  { "dstein64/vim-startuptime", cmd = "StartupTime" }, --- Top optional
} --- End of plugin lists

vim.cmd "packadd packer.nvim"

local present, packer = pcall(require, "packer")

if not present then
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
  print "Downloading packer.nvim..."
  print(
    vim.fn.system(
      string.format("git clone %s --depth 20 %s", "https://github.com/wbthomason/packer.nvim", install_path)
    )
  )
  vim.cmd "packadd packer.nvim"
  present, packer = pcall(require, "packer")
  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. install_path .. "\n" .. packer)
  end
end

do --- Hacky way of auto clean/install/compile
  vim.cmd [[
	augroup plugins
	" Reload plugins.lua
		autocmd!
		autocmd BufWritePost plugins.lua lua package.loaded["plugins"] = nil; require("plugins")
		autocmd BufWritePost plugins.lua PackerClean
	augroup END
	]]

  local state = "cleaned"
  local orig_complete = packer.on_complete
  packer.on_complete = vim.schedule_wrap(function()
    if state == "cleaned" then
      packer.install()
      state = "installed"
    elseif state == "installed" then
      packer.compile()
      state = "compiled"
    elseif state == "compiled" then
      packer.on_complete = orig_complete
      state = "done"
    end
  end)
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 6000, --- seconds
  },
  profile = {
    enable = true,
  },
  auto_clean = true,
  compile_on_sync = true,
  compile_path = vim.fn.stdpath "config" .. "/lua/compiled.lua",
}

packer.startup {
  function(use)
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end
  end,
}

return packer
