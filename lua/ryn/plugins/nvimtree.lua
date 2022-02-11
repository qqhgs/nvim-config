vim.g.nvim_tree_show_icons = {
  git = 1,
  files = 1,
  folders = 1,
}

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "",
    deleted = "",
    untracked = "U",
    ignored = "",
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
    symlink_open = "",
  },
  lsp = {
    hint = "",
    info = "",
    warning = "",
    error = "",
  },
}

local ready, nvim_tree = pcall(require, "nvim-tree")
if not ready then
  return
end

local config_ready, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_ready then
  return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.nvim_tree_respect_buf_cwd = 1

nvim_tree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  ignore_ft_on_setup = { "alpha" },
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  filters = {
    dotfiles = true,
  },
	git = {
		ignore = true,
	},
  view = {
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        { key = "h", cb = tree_cb "close_node" },
        { key = "?", cb = tree_cb "toggle_help" },
      },
    },
  },
}
