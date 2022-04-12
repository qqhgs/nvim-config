local M = {}

-- Return list of id all active buffers
M.list_bufs_active = function()
  return vim.tbl_filter(function(buf)
    return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())
end

-- Close all all buffer except current
M.close_all_but_current = function()
  local bufcur = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.list_bufs_active()) do
    if bufcur ~= bufnr then
      vim.cmd(string.format("%s %d", "bd!", bufnr))
    end
  end
end

-- set keymap
-- @params string Mode
-- @params string Mapping
-- @params string Commands
-- @params table Option (optional)
M.keymap = function(mode, key, val, opt)
  if opt == nil then
    opt = { noremap = true, silent = true }
  end
  if val then
    vim.keymap.set(mode, key, val, opt)
  else
    vim.keymap.del(mode, key)
  end
end

-- list of lua file inside specified directory
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

M.defer = function(plugin)
  vim.defer_fn(function()
    require("packer").loader(plugin)
  end, 0)
end

return M
