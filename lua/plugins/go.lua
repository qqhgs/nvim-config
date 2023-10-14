return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      run_in_floaterm = true,
      floaterm = {
        position = "right",
        width = 0.4,
      },
    })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  keys = {
    { "<leader>la", "<cmd>GoAlt!<cr>", desc = "GoAlternate" },
    { "<leader>lA", "<cmd>GoAltV!<cr>", desc = "GoAlternate Vertiacal" },
    { "<leader>lta", "<cmd>GoTestFile<cr>", desc = "Go Test File" },
    { "<leader>ltf", "<cmd>GoTestFunc<cr>", desc = "Go Test Func" },
  },
}
