vim.cmd "packadd packer.nvim"

local plugins = require "ryn.config.plugins"

local present, packer = pcall(require, "packer")

if not present then
  local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"
  print "Downloading packer.nvim..."
  print(
    vim.fn.system(
      string.format("git clone %s --depth 20 %s", "https://github.com/wbthomason/packer.nvim", install_path)
    )
  )
  vim.cmd "packadd packer.nvim"
  present, packer = pcall(require, "packer")
  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. install_path .. "\n" .. packer)
  end
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "single" }
    end,
    prompt_border = "single",
  },
  git = {
    clone_timeout = 6000, --- seconds
  },
  profile = {
    enable = true,
  },
  auto_clean = true,
  compile_on_sync = true,
  compile_path = vim.fn.stdpath "config" .. "/lua/ryn/compiled.lua",
}

packer.startup {
  function(use)
    for _, plugin in ipairs { plugins, Ryn.plugins } do
      use(plugin)
    end
  end,
}

return packer
