local M = {}

M.get_filetype_icon = function()
  -- Have this `require()` here to not depend on plugin initialization order
  local has_devicons, devicons = pcall(require, "nvim-web-devicons")
  if not has_devicons then
    return ""
  end

  local file_name, file_ext = vim.fn.expand "%:t", vim.fn.expand "%:e"
  return devicons.get_icon(file_name, file_ext, { default = true })
end

local loaded_highlights = {}

function M.get_hl(name)
  local hl = loaded_highlights[name]
  if hl and not hl.empty then
    local hl_def = {
      fg = hl.fg ~= "None" and vim.deepcopy(hl.fg) or nil,
      bg = hl.bg ~= "None" and vim.deepcopy(hl.bg) or nil,
      sp = hl.sp ~= "None" and vim.deepcopy(hl.sp) or nil,
    }
    if hl.gui then
      for _, flag in ipairs(vim.split(hl.gui, ",")) do
        if flag ~= "None" then
          hl_def[flag] = true
        end
      end
    end

    return hl_def
  end
end

function M.extract_highlight_colors(color_group, scope)
  local color = M.get_hl(color_group)
  if not color then
    if vim.fn.hlexists(color_group) == 0 then
      return nil
    end
    color = vim.api.nvim_get_hl_by_name(color_group, true)
    if color.background ~= nil then
      color.bg = string.format("#%06x", color.background)
      color.background = nil
    end
    if color.foreground ~= nil then
      color.fg = string.format("#%06x", color.foreground)
      color.foreground = nil
    end
    if color.special ~= nil then
      color.sp = string.format("#%06x", color.special)
      color.special = nil
    end
  end
  if scope then
    return color[scope]
  end
  return color
end

return M
