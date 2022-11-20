local utils = require "user.statusline.util"
local M = {}

local function set_hl(group, str, fg_color)
  local bg_color = utils.extract_highlight_colors("StatusLine", "bg")
  vim.api.nvim_set_hl(0, group, { fg = fg_color, bg = bg_color })
  return string.format("%%#%s#%s", group, str)
end

M.filename = function(opts)
  opts = opts or {}
  local modified_str

  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.fnamemodify(filename, ":t")
  filename = filename:gsub("%%", "%%%%")

  if vim.bo.modified then
    modified_str = opts.file_modified_icon or "%m"
    if modified_str ~= "" then modified_str = " " .. modified_str end
  else
    modified_str = ""
  end
  return string.format("%s%s", filename, modified_str)
end

M.filesize = function()
  local suffix = { "b", "k", "M", "G", "T", "P", "E" }
  local index = 1

  local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

  if fsize < 0 then fsize = 0 end

  while fsize > 1024 and index < 7 do
    fsize = fsize / 1024
    index = index + 1
  end

  if fsize == 0 then return nil end
  return string.format(index == 1 and "%g%s" or "%.2f%s", fsize, suffix[index])
end

M.encoding = function() return ((vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc):upper() end

M.filetype = function(opts)
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand "%:t"
  local ext = filename:match "^.*%.(.*)$"

  if ext == nil or opts == 0 then return string.format("%%#StatuslineFiletype#%s", filetype) end

  local icon, icon_group

  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    icon, icon_group = devicons.get_icon_by_filetype(vim.bo.filetype, { default = true })

    if icon_group == "Default" then
      icon_group = "StatuslineIconDefault"
      vim.api.nvim_set_hl(0, icon_group, { link = "Statusline" })
    else
      local fg = utils.extract_highlight_colors(icon_group, "fg")
      local bg = utils.extract_highlight_colors("StatusLine", "bg")
      icon_group = "StatuslineIcon" .. filetype
      vim.api.nvim_set_hl(0, icon_group, { fg = fg, bg = bg })
    end
  end

  return string.format("%%#%s#%s %%#StatuslineFiletype#%s", icon_group, icon, filetype)
end

M.lsp_progress = function()
  if not rawget(vim, "lsp") then return "" end

  local Lsp = vim.lsp.util.get_progress_messages()[1]

  if vim.o.columns < 120 or not Lsp then return "" end

  local msg = Lsp.message or ""
  local percentage = Lsp.percentage or 0
  local title = Lsp.title or ""
  local spinners = { "", "" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  local content = string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)

  return content or ""
end

M.lsp = function()
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) then return " " end
  return ""
end

M.treesitter = function()
  local b = vim.api.nvim_get_current_buf()
  if vim.treesitter.highlighter.active[b] then return "" end
  return ""
end

M.git = function()
  if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then return "" end

  local git_status = vim.b.gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("+" .. git_status.added .. " ") or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("~" .. git_status.changed .. " ") or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("-" .. git_status.removed) or ""
  local branch_name = "  " .. git_status.head .. " "

  local fn = utils.extract_highlight_colors

  return string.format(
    "%s%s%s%s",
    set_hl("StatuslineGitBranch", branch_name),
    set_hl("StatuslineGitAdded", added, fn("DiffAdded", "fg")),
    set_hl("StatuslineGitChanged", changed, fn("DiffChanged", "fg")),
    set_hl("StatuslineGitRemoved", removed, fn("DiffRemoved", "fg"))
  )
end

return M
