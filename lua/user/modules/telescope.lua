local M = {}

M.setup = function()
  local present, telescope = pcall(require, "telescope")
  if not present then return end

  local actions_present, actions = pcall(require, "telescope.actions")
  if not actions_present then return end

  local configs = {
    defaults = {
      file_ignore_patterns = { "\\.*", "node_modules" },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
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

  -- telescope.load_extension("fzy_native")
  telescope.load_extension "ui-select"
  telescope.load_extension "media_files"
end

M.keymaps = function()
  -- local function get_dropdown(name, opts)
  --   opts = opts or { previewer = false }
  --   local dropdown = require("telescope.themes").get_dropdown(opts)
  --   require("telescope.builtin")[name](dropdown)
  -- end

  vim.keymap.set(
    "n",
    "<C-p>",
    "<cmd>Telescope find_files theme=dropdown previewer=false<CR>",
    { noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<C-b>",
    "<cmd>Telescope buffers theme=dropdown previewer=false<CR>",
    { noremap = true, silent = true }
  )

  require("user.modules.whichkey").registers {
    e = { ":Telescope find_files<cr>", "File browser" },
    g = {
      o = { ":Telescope git_status<cr>", "Open changed file" },
      b = { ":Telescope git_branches<cr>", "Checkout branch" },
      c = { ":Telescope git_commits<cr>", "Checkout commit" },
      C = { ":Telescope git_bcommits<cr>", "Checkout commit (for current file)" },
    },
    s = {
      name = "Search",
      -- c = "Colorscheme",
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
  }

  -- vim.keymap.set("n", "<C-p>", function()
  --   get_dropdown("find_files")
  -- end, { noremap = true, silent = true })

  -- vim.keymap.set("n", "<Leader>bf", function()
  --   get_dropdown("buffers")
  -- end, { noremap = true, silent = true })

  -- require("utils").whichkey_reg({
  --   f = { "<cmd>Telescope find_files<cr>", "File browser" },
  -- })
end

return M
