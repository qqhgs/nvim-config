local ready, telescope = pcall(require, "telescope")
if not ready then
	return
end

local actions = require("telescope.actions")

telescope.setup({
	defaults = {

		prompt_prefix = "  ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-o>"] = actions.select_default,
				["<C-?>"] = actions.which_key,
			},

			n = {
				["<C-o>"] = actions.select_default,
			},
		},
	},
	pickers = {},
	extensions = {
		["ui-select"] = {
			require("telescope.themes").get_dropdown {}
		}
	},
})
