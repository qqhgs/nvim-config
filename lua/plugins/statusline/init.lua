return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  config = function()
    local line = require("plugins.statusline.line")

    require("heirline").setup({
      statusline = {
        fallthrough = false,
        line.SpecialStatusline,
        line.DefaultStatusline,
      },
      winbar = {
        line.DefaultWinbar,
      },
      opts = {
        -- if the callback returns true, the winbar will be disabled for that window
        -- the args parameter corresponds to the table argument passed to autocommand callbacks. :h nvim_lua_create_autocmd()
        disable_winbar_cb = function(args)
          local buf = args.buf
          local buftype = vim.tbl_contains({ "prompt", "nofile", "help", "quickfix" }, vim.bo[buf].buftype)
          local filetype = vim.tbl_contains(
            { "gitcommit", "fugitive", "Trouble", "packer", "toggleterm", "NvimTree" },
            vim.bo[buf].filetype
          )
          return buftype or filetype
        end,
      },
      -- statuscolumn = line.Statuscolumn,
    })
  end,
}
