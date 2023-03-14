return {
  "akinsho/toggleterm.nvim",
  opts = {
    open_mapping = [[<C-t>]],
    insert_mapping = false,
    -- direction = "float",
    highlights = {
      Normal = { link = "Normal" },
      NormalFloat = { link = "NormalFloat" },
      FloatBorder = { link = "FloatBorder" },
      SignColumn = { link = "Normal" },
    },
    float_opts = {
      border = "curved",
      winblend = 5,
      -- width = math.min(vim.o.columns, math.max(80, vim.o.columns - 10)),
      -- height = math.min(vim.o.lines, math.max(20, vim.o.lines - 6)),
    },
  },
  keys = function()
    ---@param command string
    ---@return function
    local function float_term(command)
      return function()
        require("toggleterm.terminal").Terminal
          :new({
            cmd = command,
            direction = "float",
          })
          :toggle()
      end
    end
    return {
      { "<C-t>", mode = "n" },
      { "<leader>te", require("util.fm").Ranger, desc = "File explorer" },
      { "<leader>tl", float_term("lazygit"), desc = "Lazygit" },
    }
  end,
}
