local M = {}

M.config = function()
  Ryn.builtins.nvimtree = {
    active = true,
    setup = {
      disable_netrw = true,
      hijack_netrw = true,
      open_on_setup = false,
      ignore_ft_on_setup = {
        "alpha",
      },
      auto_reload_on_write = true,
      hijack_unnamed_buffer_when_opening = false,
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_to_buf_dir = {
        enable = true,
        auto_open = true,
      },
      auto_close = false,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = false,
      diagnostics = {
        enable = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        ignore_list = {},
      },
      system_open = {
        cmd = nil,
        args = {},
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 200,
      },
      view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = "left",
        auto_resize = false,
        mappings = {
          custom_only = false,
          list = {},
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes",
      },
      filters = {
        dotfiles = false,
        custom = { "node_modules", ".cache", ".git" },
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      actions = {
        change_dir = {
          global = false,
        },
        open_file = {
          quit_on_open = false,
        },
        window_picker = {
          enable = false,
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {},
        },
      },
    },
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
    },
    indent_markers = 0,
    git_hl = 1,
    root_folder_modifier = ":t",
    icons = {
      default = "",
      symlink = "",
      git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        -- ignored = "◌",
        ignored = "",
      },
      folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
      },
    },
  }
end

M.setup = function()
  for opt, val in pairs(Ryn.builtins.nvimtree) do
    vim.g["nvim_tree_" .. opt] = val
  end

  local function telescope_find_files(_)
    require("Ryn.builtins.nvimtree").start_telescope "find_files"
  end
  local function telescope_live_grep(_)
    require("Ryn.builtins.nvimtree").start_telescope "live_grep"
  end

  -- Add useful keymaps
  if #Ryn.builtins.nvimtree.setup.view.mappings.list == 0 then
    Ryn.builtins.nvimtree.setup.view.mappings.list = {
      { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
      { key = "h", action = "close_node" },
      { key = "v", action = "vsplit" },
      { key = "C", action = "cd" },
      { key = "gtf", action = "telescope_find_files", action_cb = telescope_find_files },
      { key = "gtg", action = "telescope_live_grep", action_cb = telescope_live_grep },
    }
  end

  require("nvim-tree").setup(Ryn.builtins.nvimtree.setup)
end

function M.start_telescope(telescope_mode)
  local node = require("nvim-tree.lib").get_node_at_cursor()
  local abspath = node.link_to or node.absolute_path
  local is_folder = node.open ~= nil
  local basedir = is_folder and abspath or vim.fn.fnamemodify(abspath, ":h")
  require("telescope.builtin")[telescope_mode] {
    cwd = basedir,
  }
end

return M

-- vim.g.nvim_tree_show_icons = {
-- 	git = 1,
-- 	files = 1,
-- 	folders = 1,
-- }

-- vim.g.nvim_tree_indent_markers = 1
-- vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

-- vim.g.nvim_tree_icons = {
-- 	default = "",
-- 	symlink = "",
-- 	git = {
-- 		unstaged = "",
-- 		staged = "S",
-- 		unmerged = "",
-- 		renamed = "",
-- 		deleted = "",
-- 		untracked = "U",
-- 		ignored = "",
-- 	},
-- 	folder = {
-- 		arrow_open = "",
-- 		arrow_closed = "",
-- 		default = "",
-- 		open = "",
-- 		empty = "",
-- 		empty_open = "",
-- 		symlink = "",
-- 		symlink_open = "",
-- 	},
-- 	lsp = {
-- 		hint = "",
-- 		info = "",
-- 		warning = "",
-- 		error = "",
-- 	},
-- }

-- local config_ready, nvim_tree_config = pcall(require, "nvim-tree.config")
-- if not config_ready then
-- return
-- 	end

-- local tree_cb = nvim_tree_config.nvim_tree_callback

-- vim.g.nvim_tree_respect_buf_cwd = 1

-- Ryn.builtins.nvimtree = {
-- 	disable_netrw = true,
-- 	hijack_netrw = true,
-- 	ignore_ft_on_setup = { "alpha" },
-- 	auto_close = false,
-- 	open_on_tab = false,
-- 	hijack_cursor = false,
-- 	update_cwd = false,
-- 	update_focused_file = {
-- 		enable = true,
-- 		update_cwd = true,
-- 	},
-- 	filters = {
-- 		dotfiles = false,
-- 		custom = { "node_modules", ".cache" },
-- 	},
-- 	trash = {
-- 		cmd = "trash",
-- 		require_confirm = true,
-- 	},
-- 	git = {
-- 		enable = true,
-- 		ignore = false,
-- 		timeout = 200,
-- 	},
-- 	view = {
-- 		mappings = {
-- 			-- list = {
-- 			--   { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
-- 			--   { key = "h", cb = tree_cb "close_node" },
-- 			--   { key = "?", cb = tree_cb "toggle_help" },
-- 			-- },
-- 			custom_only = false,
-- 			list = {},
-- 		},
-- 	},
-- }
