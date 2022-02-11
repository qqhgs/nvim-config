local impatient_present, impatient = pcall(require, "impatient")
if impatient_present then
  impatient.enable_profile()
end

local modules = {
  "general",
  "keymaps",
  "autocmds",
}

for _, module in ipairs(modules) do
  local present, mod = pcall(require, "ryn.settings." .. module)
  if not present then
    error("Error: can't load module: " .. mod)
  end
end

local compiled_present, _ = pcall(require, "ryn.compiled")
if not compiled_present then
  print "compiled.lua not found. run 'PackerSync' or type <SPACE>ps"
end
