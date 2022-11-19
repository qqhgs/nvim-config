local M = {}

function M.setup()
  local present, wk = pcall(require, "which-key")
  if not present then
    return
  end

  local configs = {
    window = { border = "rounded" },
    ignore_missing = true,
    layout = { spacing = 6 },
    icons = {
      separator = "->",
    },
  }

  vim.opt.timeoutlen = 100

  wk.setup(configs)
end

function M.registers(mappings)
  local present, wk = pcall(require, "which-key")
  if not present then
    return
  end
  wk.register(mappings, { prefix = "<Leader>" })
end

return M
