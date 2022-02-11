local present, luasnip = pcall(require, "luasnip")
if present then
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  luasnip.filetype_extend("php", { "php", "html" })

  require("luasnip/loaders/from_vscode").load()
end
