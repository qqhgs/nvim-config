local icons = require("const.icons")

local window_width_limit = 100

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
  hide_in_width = function() return vim.o.columns > window_width_limit end,
}

local function fg(name)
  return function()
    ---@type {foreground?:number}?
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
  end
end

return {
  location = function()
    local line = vim.fn.line(".")
    local col = vim.fn.virtcol(".")
    return string.format("%d,%d", line, col)
  end,
  branch = {
    "b:gitsigns_head",
    icon = icons.git.Branch,
    -- color = { gui = "bold" },
  },
  treesitter = {
    function()
      local buf = vim.api.nvim_get_current_buf()
      if vim.treesitter.highlighter.active[buf] then return icons.ui.Fire end
      return ""
    end,
    cond = conditions.hide_in_width,
    color = fg("special"),
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
      if next(buf_clients) == nil then return "" end
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then table.insert(buf_client_names, client.name) end
      end

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = icons.ui.Target .. " [" .. table.concat(unique_client_names, ", ") .. "]"

      return language_servers
    end,
    color = fg("constant"),
  },
}
