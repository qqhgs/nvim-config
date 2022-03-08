for _, v in
  ipairs {
    "options",
    "keymaps",
  }
do
  require("ryn.config." .. v).setup()
end

local plugins = {
  -- Formatting
  "cmp",
  "autopairs",
  "lsp",
  "null_ls",
  "luasnip",
  "treesitter",

  -- UI
  "rynkai",
  "gitsigns",
  "indentline",
  "statusline",

  -- Extend
  "comment",
  "nvimtree",
  "bufferline",
  "toggleterm",
  "telescope",
  "project",
  "whichkey",
}

for _, value in ipairs(plugins) do
  require("ryn.plugins." .. value).setup()
end

pcall(require, "ryn.user.setup")
