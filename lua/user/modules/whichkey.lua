local present, whichkey = pcall(require, "which-key")
if not present then
  return
end

local keys = {
  normal_mode = {
    c = "Close Buffer",
    e = "File Explore",
    f = "Find",
    h = "No highlight search",
    r = "Replace text on cursor",
    ["/"] = "Comment line",
    b = {
      name = "Buffers",
      c = { ":lua require('user.util').close_all_but_current()<CR>", "Close all but current" }, -- TODO: implement this for bufferline
      d = { ":%bd!<CR>", "Close all" }, -- TODO: implement this for bufferline
      f = "Find",
      h = { ":BufferLineCyclePrev<CR>", "Prev" },
      l = { ":BufferLineCycleNext<CR>", "Next" },
      p = "Pick",
    },
    g = {
      name = "Git",
      j = { ":lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { ":lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { ":lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { ":lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { ":lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { ":lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { ":lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        ":lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { ":Telescope git_status<cr>", "Open changed file" },
      b = { ":Telescope git_branches<cr>", "Checkout branch" },
      c = { ":Telescope git_commits<cr>", "Checkout commit" },
      C = {
        ":Telescope git_bcommits<cr>",
        "Checkout commit (for current file)",
      },
      d = {
        ":Gitsigns diffthis HEAD<cr>",
        "Git Diff",
      },
    },
    l = {
      name = "LSP",
      a = "Code action",
      c = "References",
      d = "Definition",
      e = "Declaration",
      f = "Format",
      F = "Toggle auto format",
      h = "Hover",
      i = "Info",
      r = "Rename",
      q = "Loc list",
    },
    p = {
      name = "Packer",
      a = { ":PackerClean<CR>", "Clean" },
      c = { ":PackerCompile<CR>", "Compile (Re)" },
      i = { ":PackerInstall<CR>", "Install" },
      u = { ":PackerUpdate<CR>", "Update" },
      s = "Sync",
      S = { ":PackerStatus<CR>", "Status" },
      p = { ":PackerProfile<CR>", "Profile" },
    },
    s = {
      name = "Search",
      c = "Colorscheme",
      p = { ":Telescope projects<CR>", "Project" },
      g = { ":Telescope live_grep theme=ivy<CR>", "Live grep" },
      h = { ":Telescope help_tags<cr>", "Help" },
      l = { ":Telescope resume<cr>", "Last search" },
      m = { ":Telescope man_pages<cr>", "Man pages" },
      r = { ":Telescope oldfiles<cr>", "Recent file" },
      R = { ":Telescope registers<cr>", "Registers" },
      k = { ":Telescope keymaps<cr>", "Keymaps" },
      C = { ":Telescope commands<cr>", "Commands" },
    },
    q = {
      name = "Session",
      s = { ":lua require('persistence').load()<CR>", "Load last by dir" },
      l = { ":lua require('persistence').load({ last = true })<CR>", "Load last" },
      d = { ":lua require('persistence').stop()<CR>", "Stop" },
    },
    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
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

local configs = {
  window = { border = "rounded" },
  ignore_missing = true,
  layout = { spacing = 6 },
  spelling = {
    enabled = true,
  },
  icons = {
    separator = "->",
  },
}

vim.opt.timeoutlen = 100

whichkey.setup(configs)

for key, value in pairs(keys) do
  whichkey.register(value, opts[key])
end
