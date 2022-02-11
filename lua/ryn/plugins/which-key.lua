local keys = {
  normal_mode = {
    c = "Close buffer --soft",
    e = "File Explore",
    f = "Find text",
    h = "No highlight search",
    r = "Replace text on cursor",
    x = "Close buffer --win",
    ["/"] = "Comment line",
    b = {
      name = "Buffers",
      f = "Find",
      p = "Pick",
      c = "Pick close",
    },
    g = {
      name = "Git",
      b = { ":Telescope git_branches<cr>", "Checkout branch" },
      c = { ":Telescope git_commits<cr>", "Checkout commit" },
    },
    l = {
      name = "LSP",
      f = "Format",
      h = "Hover",
      i = "Info",
      r = "Rename",
    },
    p = {
      name = "Packer",
      a = "Clean",
      c = "Compile (Re)",
      i = "Install",
      u = "Update",
      s = "Sync",
      S = "Status",
      p = "Profile",
    },
    s = {
      name = "Search",
      c = "Colorscheme",
      p = "Project",
      h = "Help",
      l = "Last search",
      m = "Man pages",
      r = "Recent file",
      R = "Registers",
      k = "Keymaps",
      C = "Commands",
    },
    q = {
      name = "Session",
      s = "Load dir",
      l = "Load last",
      d = "Stop",
    },
  },
  visual_mode = {
    ["/"] = "Comment line",
    ["b"] = "Comment block",
  },
}

local opts = {
  normal_mode = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,
    noremap = true,
    nowait = true,
  },
  visual_mode = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
}

local ready, which_key = pcall(require, "which-key")
if not ready then
  return
end

vim.opt.timeoutlen = 200

which_key.setup {
  window = { border = "rounded" },
  ignore_missing = true,
  layout = { spacing = 4 },
  spelling = {
    enabled = true,
  },
  icons = {
    separator = "->",
  },
}
which_key.register(keys.normal_mode, opts.normal_mode)
which_key.register(keys.visual_mode, opts.visual_mode)
