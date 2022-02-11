local ready, null_ls = pcall(require, "null-ls")
if not ready then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local function getDir(command, str)
  local handle = io.popen(command)
  local result = handle:read "*a"
  handle:close()
	if str ~= nil then
		return result:gsub(str, "")
	end
  return result
end

null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      prefer_local = getDir("which node", "/node"),
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "html",
        "json",
        "markdown",
      },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
  },
}
