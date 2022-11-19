local present, impatient = pcall(require, "impatient")
if present then
  impatient.enable_profile()
end

local cores = {
  "autocmds",
  "options",
  "keymaps",
  "plugins",
}
for _, core in ipairs(cores) do
  pcall(require, "user." .. core)
end

present, _ = pcall(require, "user.compiled")
if not present then
  vim.cmd [[PackerSync]]
end
