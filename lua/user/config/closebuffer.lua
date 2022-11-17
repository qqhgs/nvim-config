require("user.modules.whichkey").registers {
  c = { ":BDelete! this<CR>", "Close buffer" },
  b = {
    c = { ":BDelete! other<CR>", "Close other" },
    d = { ":BDelete! all<CR>", "Close all" },
  },
}
