local ready, project = pcall(require, "project_nvim")
if not ready then
	return
end
project.setup({
	patterns = { ".git", "Makefile", "package.json" },
})

local present, telescope = pcall(require, "telescope")
if not present then
	return
end

telescope.load_extension("projects")
