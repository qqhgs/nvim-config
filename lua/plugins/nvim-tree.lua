local function on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
  vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
  vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
end

return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
  opts = function()
    return {
      view = {
        width = 35,
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      git = {
        ignore = false,
        timeout = 200,
      },
      filters = {
        custom = { "node_modules", "\\.cache" },
      },
      on_attach = on_attach,
    }
  end,
  configi = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
  keys = {
    { "<C-n>", "<cmd>NvimTreeFindFileToggle!<cr>", desc = "Explorer" },
  },
}
