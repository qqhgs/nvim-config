local M = {}

M.enable_format_on_save = function()
  vim.cmd [[
		augroup format_on_save
			autocmd! 
			autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
		augroup end
		]]
end

M.disable_format_on_save = function()
  if vim.fn.exists "#format_on_save" == 1 then
    vim.cmd "au! format_on_save"
  end
end

M.toggle_format_on_save = function()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
    print "Enabled format on save."
  else
    M.disable_format_on_save()
    print "Disabled ormat on save."
  end
end

M.is_array = function(t)
  local i = 0
  for _ in pairs(t) do
    i = i + 1
    if t[i] == nil then
      return false
    end
  end
  return true
end

M.insert_to_left = function(left, right)
  local is_array = require("ryn.utils").is_array
  if not is_array(left) and is_array(right) then
    return
  end
  for _, v in ipairs(right) do
    table.insert(left, v)
  end
end

M.merge_to_left = function(default_config, user_config)
  local utils = require "ryn.utils"
  for key, value in pairs(user_config) do
    if type(value) == "table" and type(default_config[key] or false) == "table" then
      if utils.is_array(value) then
        utils.insert_to_left(default_config[key], value)
      else
        utils.merge_to_left(default_config[key], value)
      end
    else
      default_config[key] = value
    end
  end
end

return M
