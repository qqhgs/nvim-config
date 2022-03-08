local impatient_present, impatient = pcall(require, "impatient")
if impatient_present then
  impatient.enable_profile()
end

require("ryn")
