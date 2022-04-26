local util = require"user.util"
local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local actions_present, actions = pcall(require, "telescope.actions")
if not actions_present then
  return
end

local configs = {
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
        -- ["<C-o>"] = actions.select_default,
        ["<C-?>"] = actions.which_key,
        ["<C-s>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
      },
      n = {
        ["<C-o>"] = actions.select_default,
      },
    },
  },
  pickers = {},
  extensions = { ["ui-select"] = {
    require("telescope.themes").get_dropdown {},
  } },
}

telescope.setup(configs)

util.keymap("n", "<C-p>", ":lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{no_ignore = true, previewer = false})<CR>")
util.keymap("n", "<Leader>bf", ":lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>")

telescope.load_extension("ui-select")
