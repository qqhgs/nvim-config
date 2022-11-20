local present, persistence = pcall(require, "persistence")
if not present then
  return
end

persistence.setup()

require("user.config.whichkey").registers {
  S = {
    name = "Session",
    s = { ":lua require('persistence').load()<CR>", "Load last by dir" },
    l = { ":lua require('persistence').load({ last = true })<CR>", "Load last" },
    d = { ":lua require('persistence').stop()<CR>", "Stop" },
  },
}
