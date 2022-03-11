local M = {}

M.config = function()
  Ryn.builtins.alpha = {
    header = {
      type = "text",
      val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      },
      opts = {
        position = "center",
        hl = "AlphaHeader",
      },
    },
    buttons = {
      type = "group",
      val = {
        { "f", "  Find file", ":Telescope find_files <CR>" },
        { "e", "  New file", ":ene <BAR> startinsert <CR>" },
        { "p", "冷 Find project", ":Telescope projects <CR>" },
        { "r", "  Recent files", ":Telescope oldfiles <CR>" },
        { "g", "  Live grep", ":Telescope live_grep <CR>" },
        { "l", "  Last Session", ":lua require('persistence').load({ last = true })<CR>" },
        { "t", "  Colorscheme  ", ":Telescope rynkai<CR>" },
        { "s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>" },
        { "q", "  Quit", ":qa<CR>" },
      },
      opts = {
        spacing = 1,
      },
    },
  }
end

M.setup = function()
  local dashboard = require "alpha.themes.dashboard"

  local btn_values = {}
  for _, v in ipairs(Ryn.builtins.alpha.buttons.val) do
    table.insert(btn_values, dashboard.button(v[1], v[2], v[3]))
  end
  Ryn.builtins.alpha.buttons.val = btn_values

  require("alpha").setup {
    layout = {
      { type = "padding", val = 5 },
      Ryn.builtins.alpha.header,
      { type = "padding", val = 2 },
      Ryn.builtins.alpha.buttons,
    },
    opts = {},
  }
end

return M
