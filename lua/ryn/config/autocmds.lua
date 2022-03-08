vim.cmd [[
  augroup __general_settings
    autocmd!
    autocmd TextYankPost * lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd TermOpen * setlocal nonumber norelativenumber
  augroup end
]]

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("ryn.utils").toggle_format_on_save()' ]]
