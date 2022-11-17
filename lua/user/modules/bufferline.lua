require("bufferline").setup {
  options = {
    close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level)
      local icon = level:match "error" and " " or " "
      return " " .. icon .. count .. " "
    end,
    separator_style = { "", "" },
    offsets = {
      {
        filetype = "neo-tree",
        highlight = "NeoTreeNormal",
        padding = 1,
      },
    },
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match "%.md" then
        return vim.fn.fnamemodify(buf.name, ":t:r")
      end
    end,
    modified_icon = " ",
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = "id",
  },
}

vim.keymap.set("n", "<Leader>bp", ":BufferLinePick<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>bP", ":BufferLinePickClose<CR>", { noremap = true, silent = true })
require("user.modules.whichkey").registers({
	b = {
		p = { ":BufferlinePick<CR>", "Pick buffer"},
		P = { ":BufferlinePick<CR>", "Pick buffer to close"}
	}
})

