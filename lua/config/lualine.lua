local ready, lualine = pcall(require, "lualine")
if not ready then
	return
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local conds = {
	hide_in_width = function()
		return vim.fn.winwidth(0) > 70
	end,
}

local components = {
	mode = {
		"mode",
		cond = conds.hide_in_width,
	},
	filename = {
		"filename",
		symbols = {
			modified = " ",
			readonly = " ",
		},
	},
	filesize = {
		"filesize",
		cond = conds.hide_in_width,
	},
	location = {
		"location",
		cond = conds.hide_in_width,
	},
	encoding = {
		"encoding",
		cond = conds.hide_in_width,
	},
	branch = {
		"branch",
		icons_enabled = true,
		icon = "",
	},
	diff = {
		"diff",
		source = diff_source,
		-- colored = false,
		symbols = { added = " ", modified = " ", removed = " " },
		cond = conds.hide_in_width,
	},
	lsp_progress = {
		"lsp_progress",
		display_components = { "lsp_client_name", { "title", "percentage", "message" } },
	},
	treesitter = {
		function()
			local b = vim.api.nvim_get_current_buf()
			if next(vim.treesitter.highlighter.active[b]) then
				return ""
			end
			return ""
		end,
		cond = conds.hide_in_width,
	},
	lsp = {
		function()
			local buf_clients = vim.lsp.buf_get_clients()
			if next(buf_clients) then
				return " "
			end
			return ""
		end,
		-- icon = " ",
		cond = conds.hide_in_width,
	},
	diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		-- sections = { "error", "warn" },
		symbols = { error = " ", warn = " ", info = " ", hint = " " },
		-- colored = false,
		update_in_insert = false,
		-- always_visible = true,
		cond = conds.hide_in_width,
	},
	scrollbar = {
		function()
			local current_line = vim.fn.line(".")
			local total_lines = vim.fn.line("$")
			local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
			local line_ratio = current_line / total_lines
			local index = math.ceil(line_ratio * #chars)
			return chars[index]
		end,
		padding = { left = 0, right = 0 },
		cond = conds.hide_in_width,
	},
}

lualine.setup({
	options = {
		-- section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
		disabled_filetypes = { "NvimTree", "toggleterm" },
		theme = "rynkai",
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		lualine_b = {
			components.branch,
		},
		lualine_c = {
			components.filename,
			components.filesize,
			components.diagnostics,
			components.diff,
		},
		lualine_x = {
			components.treesitter,
			components.lsp,
			components.encoding,
			"filetype",
		},
		lualine_y = {
			components.location,
		},
		lualine_z = {
			-- components.scrollbar,
			components.progress,
		},
	},
})
