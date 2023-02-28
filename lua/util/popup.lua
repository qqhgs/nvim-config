local M = {}

function M.popup()
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
    },
    position = "50%",
    size = {
      width = "80%",
      height = "60%",
    },
  })

  -- mount/open the component
  popup:mount()

  vim.api.nvim_command("startinsert")

  popup:map("i", "q", function() popup:unmount() end, { noremap = true })

  -- set content
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, {vim.fn.termopen("ranger")})
end

return M
