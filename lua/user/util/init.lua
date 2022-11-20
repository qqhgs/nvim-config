local M = {}

M.defer = function(plugin)
  vim.defer_fn(function() require("packer").loader(plugin) end, 100)
end

M.toggle_statusline = function()
  local opt = {
    "neo-tree",
    "toggleterm",
    "alpha",
  }
  local ft = vim.bo.filetype
  for _, v in ipairs(opt) do
    if ft == v then
      vim.opt.laststatus = 0
      return
    else
      vim.opt.laststatus = 3
    end
  end
end

return M
