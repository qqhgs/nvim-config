return {
  "rest-nvim/rest.nvim",
  ft = { "http" },
  config = function()
    require("rest-nvim").setup()

    vim.keymap.set("n", "<CR>", require("rest-nvim").run, { buffer = true, silent = true })
  end,
}
