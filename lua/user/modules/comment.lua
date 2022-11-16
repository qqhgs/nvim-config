require("Comment").setup {
  ignore = "^$",
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
}
local api = require "Comment.api"
vim.keymap.set("n", "<C-_>", api.call("toggle.linewise.current", "g@$"), { expr = true })
vim.keymap.set("x", "<C-_>", api.call("toggle.linewise", "g@$"), { expr = true })
