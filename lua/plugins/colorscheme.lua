return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VimEnter",
    config = function()
      require("catppuccin").setup({
        custom_highlights = function()
          return {
            ["PmenuSel"] = { bg = "NONE" },
            ["DiagnosticUnderlineError"] = { undercurl = true },
            ["DiagnosticUnderlineWarn"] = { undercurl = true },
            ["DiagnosticUnderlineHint"] = { undercurl = true },
            ["DiagnosticUnderlineInfo"] = { undercurl = true },
            ["DiagnosticUnderlineOk"] = { undercurl = true },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
