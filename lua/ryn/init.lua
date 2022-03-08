require("ryn.config"):init()

local compiled_present, _ = pcall(require, "ryn.compiled")
if not compiled_present then
  print "compiled.lua not found. run 'PackerSync' or type <SPACE>ps"
end
