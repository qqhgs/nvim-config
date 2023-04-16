---@param actions string
---@return function
local actions = function(actions)
  return function(...) require("telescope.actions")[actions](...) end
end

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-project.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  keys = {
    { "<C-p>", "<cmd>Telescope find_files previewer=false theme=dropdown<cr>", desc = "Find files" },
    { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    {
      "<leader>,",
      "<cmd>Telescope buffers show_all_buffers=true previewer=false theme=dropdown<cr>",
      desc = "Find buffer",
    },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- search
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sp", "<cmd>Telescope project<cr>", desc = "Project" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
  },
  opts = {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      mappings = {
        i = {
          ["<C-n>"] = actions("move_selection_next"),
          ["<C-p>"] = actions("move_selection_previous"),
          ["<C-j>"] = actions("cycle_history_next"),
          ["<C-k>"] = actions("cycle_history_prev"),
        },
        n = {
          ["<C-n>"] = actions("move_selection_next"),
          ["<C-p>"] = actions("move_selection_previous"),
        },
      },
    },
    pickers = {
      buffers = {
        -- theme = "dropdown",
        -- previewer = false,
        -- initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions("delete_buffer"),
          },
          n = {
            ["q"] = actions("close"),
            ["o"] = actions("select_default"),
            ["dd"] = actions("delete_buffer"),
          },
        },
      },
    },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("project")
  end,
}
