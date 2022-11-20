local present, luasnip = pcall(require, "luasnip")
if not present then
  return
end
local configs = {
  setup = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  },
  ft_extend = {
    php = { "php", "html" },
  },
}
luasnip.config.set_config(configs.setup)

for key, value in pairs(configs.ft_extend) do
  luasnip.filetype_extend(key, value)
end

require("luasnip/loaders/from_vscode").load()
-- require("luasnip/loaders/from_vscode").load { paths = vim.fn.stdpath "config" .. "/snippets" }
