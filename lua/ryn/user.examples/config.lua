local configs = {
  "colorizer",
}

for _, v in ipairs(configs) do
  require("ryn.user.plugins." .. v).config()
end
