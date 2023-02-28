local path = "~/workspaces/nvim/mayu.nvim"
return {

  {
    dir = "~/workspaces/nvim/mayu.nvim",
    lazy = false,
    config = function()
      require("mayu").setup({
        theme = "mirage",
        config_file = vim.fn.stdpath("config") .. "/lua/plugins/colorscheme.lua",
        mayu_dir = path .. "/lua/mayu/colors",
      })

      vim.cmd("colorscheme mayu")

      require("telescope").load_extension("mayu")

      vim.keymap.set("n", "<leader>sc", "<cmd>Telescope mayu<cr>", { desc = "Change themes" })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    -- config = function() require("tokyonight").load() end,
  },
}
