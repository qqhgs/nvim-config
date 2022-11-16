local present, whichkey = pcall(require, "which-key")
if not present then return end

local configs = {
  window = { border = "rounded" },
  ignore_missing = true,
  layout = { spacing = 6 },
  icons = {
    separator = "->",
  },
}

vim.opt.timeoutlen = 100

whichkey.setup(configs)


local function registers(mappings) require("which-key").register(mappings, { prefix = "<Leader>" }) end

return {
	registers = registers
}
