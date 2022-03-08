require("persistence").setup()

local plugins = {
  "alpha",
  "colorizer",
}

for _, plugin in ipairs(plugins) do
  require("ryn.user.plugins." .. plugin).setup()
end
