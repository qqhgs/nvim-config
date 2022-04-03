local impatient_present, impatient = pcall(require, "impatient")
if impatient_present then
  impatient.enable_profile()
end

local cores = {
  "autocmds",
  "options",
  "keymaps",
  "plugins",
}
for _, core in ipairs(cores) do
  require("user." .. core)
end

local compiled_present, _ = pcall(require, "user.compiled")
if not compiled_present then
	vim.cmd [[PackerCompile]]
	-- print "compiled.lua not found. run 'PackerSync' or type <SPACE>ps"
end
