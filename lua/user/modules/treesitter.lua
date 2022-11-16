local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then return end

vim.opt.runtimepath:append(vim.fn.stdpath "data" .. "/site/parser/")

treesitter.setup {
  ensure_installed = {
    "html",
    "css",
    "scss",
    "go",
    "json",
    "javascript",
    "typescript",
    "tsx",
    "svelte",
    "lua",
    "vim",
    "bash",
    "markdown",
  },
  auto_install = true,
  parser_install_dir = vim.fn.stdpath "data" .. "/site/parser/",
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  rainbow = {
    enable = true,
    disable = { "html" },
    extended_mode = false,
    max_file_lines = nil,
  },
  autopairs = { enable = true },
  autotag = { enable = true },
  incremental_selection = { enable = true },
  indent = { enable = false },

  -- vim-matchup
  matchup = {
    enable = true,
  },
}

require("user.modules.whichkey").registers {
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

