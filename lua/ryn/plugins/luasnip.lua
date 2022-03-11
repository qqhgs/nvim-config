local M = {}

M.config = function()
  Ryn.builtins.luasnip = {
    config = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    },
    ft_extend = {
      php = { "php", "html" },
    },
  }
end

M.setup = function()
  local _, luasnip = pcall(require, "luasnip")
  luasnip.config.set_config(Ryn.builtins.luasnip.config)

  for key, value in pairs(Ryn.builtins.luasnip.ft_extend) do
    luasnip.filetype_extend(key, value)
  end

  require("luasnip/loaders/from_vscode").load { paths = vim.fn.stdpath "config" .. "/snippets" }
end

return M
