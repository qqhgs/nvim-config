local M = {}

vim.api.nvim_exec(
  [[augroup Statusline
        au!
        au WinEnter,BufEnter * setlocal statusline=%!v:lua.require'user.statusline'.setup()
      augroup END]],
  false
)

M.setup = function()
  local components = require "user.statusline.components"

  local fill = { strings = { "%=" } }

  return M.combine_groups {
    -- "%<", -- Mark general truncate point
    { hl = "StatuslineGitBranch", strings = { components.git() } },
    { hl = "StatuslineFilename", strings = { components.filename() } },
    fill,
    { hl = "StatuslineLspProgress", strings = { components.lsp_progress() } },
    fill,
    { hl = "StatuslineTreesitter", strings = { components.treesitter() } },
    { hl = "StatuslineLsp", strings = { components.lsp() } },
    { hl = "StatuslineEncoding", strings = { components.encoding() } },
    { strings = { components.filetype() } },
    { hl = "StatuslineFilesize", strings = { components.filesize() } },
  }
end

M.combine_groups = function(groups)
  local parts = vim.tbl_map(function(s)
    --stylua: ignore start
    if type(s) == 'string' then return s end
    if type(s) ~= 'table' then return '' end

    local string_arr = vim.tbl_filter(function(x) return type(x) == 'string' and x ~= '' end, s.strings or {})
    local str = table.concat(string_arr, ' ')

    -- Use previous highlight group
    if s.hl == nil then
      return (' %s '):format(str)
    end

    -- Allow using this highlight group later
    if str:len() == 0 then
      return string.format('%%#%s#', s.hl)
    end

    return string.format('%%#%s# %s ', s.hl, str)
    --stylua: ignore end
  end, groups)

  return table.concat(parts, "")
end

return M
