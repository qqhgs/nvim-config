return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(_, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then return true end
        end,
      },
      indent = { enable = true },
      autotag = {
        enable = true,
      },
      textobjects = {
        swap = {
          enable = false,
          -- swap_next = textobj_swap_keymaps,
        },
        -- move = textobj_move_keymaps,
        select = {
          enable = false,
          -- keymaps = textobj_sel_keymaps,
        },
      },
      textsubjects = {
        enable = true,
        keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = {
        "lua",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
