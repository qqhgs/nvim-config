local impatient_present, impatient = pcall(require, "impatient")
if impatient_present then
  impatient.enable_profile()
end

require("user")

local compiled_present, _ = pcall(require, "user.compiled")
if not compiled_present then
  print "compiled.lua not found. run 'PackerSync' or type <SPACE>ps"
end
