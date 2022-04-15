local autocmd_groups = {
  __generals = {
    { "FileType", "qf,help,man,startuptime,packer", "nnoremap <silent> <buffer> q :close<CR>" },
    {
      "TextYankPost",
      "*",
      "lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200})",
    },
    {
      "BufWinEnter",
      "dashboard",
      "setlocal cursorline signcolumn=yes cursorcolumn number",
    },
    { "FileType", "qf", "set nobuflisted" },
    { "VimLeavePre", "*", "set title set titleold=" },
    { "TermOpen", "*", "setlocal nonumber norelativenumber" },
    { "VimEnter,BufEnter,BufLeave", "*", "lua require'user.util'.toggle_statusline()" },
  },
}

for group_name, definition in pairs(autocmd_groups) do
  vim.cmd("augroup " .. group_name)
  vim.cmd [[autocmd!]]

  for _, def in pairs(definition) do
    local command = table.concat(vim.tbl_flatten { "autocmd", def }, " ")
    vim.cmd(command)
  end

  vim.cmd "augroup END"
end
