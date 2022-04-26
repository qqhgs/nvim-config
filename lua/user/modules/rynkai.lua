local present, rynkai = pcall(require, "rynkai")
if not present then
  return
end

local telescope_present, telescope = pcall(require, "telescope")
if not telescope_present then
  return
end

local config_file = vim.fn.stdpath "config" .. "/lua/user/modules/rynkai.lua"
local rynkai_dir = vim.fn.stdpath "data" .. "/site/pack/packer/opt/rynkai.nvim/lua/rynkai/colors/"

rynkai.setup {
  theme = "ayu", -- this field is a must.
  config_file = config_file,
  rynkai_dir = rynkai_dir,
}

vim.cmd [[ colorscheme rynkai ]]

telescope.load_extension "rynkai"
vim.api.nvim_set_keymap("n", "<Leader>sc", ":Telescope rynkai<CR>", { noremap = true, silent = true })


local M = {}

M.colorscheme_switcher = function(opts)
  local pickers, finders, action_state, conf, actions
  actions = require "telescope.actions"
  pickers = require "telescope.pickers"
  finders = require "telescope.finders"
  action_state = require "telescope.actions.state"
  conf = require("telescope.config").values

  local before_color = require("rynkai.config").options.theme
  local need_restore = true

  local themes = require("rynkai.fn").list_themes()
  local colors = { before_color }

  themes = vim.list_extend(
    colors,
    vim.tbl_filter(function(color)
      return color ~= before_color
    end, themes)
  )


  local picker = pickers.new(opts, {
    prompt_title = "Change color style",
    finder = finders.new_table {
      results = colors,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          print "[telescope] Nothing currently selected"
          return
        end

        actions.close(prompt_bufnr)
        need_restore = false
        require("rynkai.fn").change(selection[1])
        require("rynkai.fn").change_theme(before_color, selection[1])
      end)
      return true
    end,
  })

  local close_windows = picker.close_windows
  picker.close_windows = function(status)
    close_windows(status)
    if need_restore then
      require("rynkai.fn").change(before_color)
    end
  end

  picker:find()
end

return M
