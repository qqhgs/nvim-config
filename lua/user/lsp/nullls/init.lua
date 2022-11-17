local M = {}

local nls = require "null-ls"
local nls_utils = require "null-ls.utils"
local b = nls.builtins

local sources = {
	-- formatting
	b.formatting.stylua,
	b.formatting.gofumpt,

	-- hover
	b.hover.dictionary,
}

function M.setup(opts)
	nls.setup {
		debug = true,
		debounce = 150,
		save_after_format = true,
		sources = sources,
		on_attach = opts.on_attach,
		root_dir = nls_utils.root_pattern ".git",
	}
end

return M
