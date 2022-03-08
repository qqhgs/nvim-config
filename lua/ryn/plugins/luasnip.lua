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
  local luasnip = require "luasnip"
  luasnip.config.set_config(Ryn.builtins.luasnip.config)

  for key, value in pairs(Ryn.builtins.luasnip.ft_extend) do
    luasnip.filetype_extend(key, value)
  end

  require("luasnip/loaders/from_vscode").load()
end

return M
