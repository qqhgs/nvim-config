return {
  "ray-x/go.nvim",
  event = "VeryLazy",
  ft = { "go", "gomod" },
  dependencies = {
    "ray-x/guihua.lua",
  },
  config = function() require("go").setup() end,
  build = ':lua require("go.install").update_all_sync()',
}
