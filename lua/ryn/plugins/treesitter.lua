local M = {}

M.config = function()
  Ryn.builtins.treesitter = {
    ensure_installed = {
      "lua",
    },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    autopairs = {
      enable = true,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    indent = { enable = true },
  }
end

M.setup = function()
  -- vim.opt.foldmethod = "expr"
  -- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

  require("nvim-treesitter.configs").setup(Ryn.builtins.treesitter)
end

return M
