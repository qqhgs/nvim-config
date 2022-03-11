local impatient_present, impatient = pcall(require, "impatient")
if impatient_present then
  impatient.enable_profile()
end

require("ryn.config"):init()

if vim.fn.empty(vim.fn.glob(vim.fn.stdpath "config" .. "/lua/ryn/compiled.lua")) > 0 then
  print "compiled.lua not found. run 'PackerSync' or type <SPACE>ps"
else
  require("ryn.config"):load()
  require "ryn.compiled"
end
