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

M.insert_to_left = function(array, value)
  if vim.tbl_islist(array) and not vim.tbl_islist(value) then
    return
  end
  for _, v in ipairs(value) do
    table.insert(array, v)
  end
end

M.merge_to_left = function(default_config, user_config)
  local utils = require "ryn.utils"
  for key, value in pairs(user_config) do
    if type(value) == "table" and type(default_config[key] or false) == "table" then
      if vim.tbl_islist(value) then
        utils.insert_to_left(default_config[key], value)
      else
        utils.merge_to_left(default_config[key], value)
      end
    else
      default_config[key] = value
    end
  end
end

M.list_files = function(directory, return_type)
  local results = {}
  -- list all the contents of the folder and filter out files with .lua extension, then append to results table
  local fd = vim.loop.fs_scandir(directory)
  if fd then
    while true do
      local name, typ = vim.loop.fs_scandir_next(fd)
      if name == nil then
        break
      end
      if typ ~= "directory" and string.find(name, ".lua$") then
        -- return the table values as keys if specified
        if return_type == "keys_as_value" then
          results[vim.fn.fnamemodify(name, ":r")] = true
        else
          table.insert(results, vim.fn.fnamemodify(name, ":r"))
        end
      end
    end
  end
  return results
end

-- if you want set some value to nil
-- maybe you don't need some builtin plugins or keymaps
M.remove_value_in_tbl = function(tbl, tbl_removals)
  if not vim.tbl_isempty(tbl_removals) then
    for _, v in pairs(tbl_removals) do
      tbl[v] = nil
    end
  end
  return tbl
end

M.remove_def_plugins = function(plugins)
  for i, v in ipairs(plugins) do
    for _, p in ipairs(Ryn.plugins.excludes or {}) do
      if v[1] == p then
        plugins[i][1] = nil
      end
    end
  end
  return plugins
end

M.list_bufs_active = function()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())
end

M.close_all_but_current = function()
  local bufcur = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.list_bufs_active()) do
    if bufcur ~= bufnr then
      vim.cmd(string.format("%s %d", "bd!", bufnr))
    end
  end
end

return M
