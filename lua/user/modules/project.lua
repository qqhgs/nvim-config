local present, project = pcall(require, "project_nvim")
if not present then
  return
end

local telescope_present, telescope = pcall(require, "telescope")
if not telescope_present then
  return
end

local configs = {
  patterns = { ".git", "Makefile", "package.json" },
}

project.setup(configs)

telescope.load_extension "projects"
