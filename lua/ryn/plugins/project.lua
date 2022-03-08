local M = {}

M.config = function()
  Ryn.builtins.project = {
    patterns = { ".git", "Makefile", "package.json" },
  }
end

M.setup = function()
  require("project_nvim").setup(Ryn.builtins.project)
  require("telescope").load_extension "projects"
end

return M
