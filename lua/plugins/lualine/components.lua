local icons = require("const.icons")

local window_width_limit = 100

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 end,
  hide_in_width = function() return vim.o.columns > window_width_limit end,
}

local isempty = function(s) return s == nil or s == "" end

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
    return string.format("Ln%3d,Col %-2d", line, col)
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
  breadcrumb = {
    function()
      local file_path = vim.fn.expand("%:~:.:h")
      local filename = vim.fn.expand("%:t")
      local file_type = vim.fn.expand("%:e")
      local value = ""
      local file_icon = ""

      file_path = file_path:gsub("^%.", "")
      file_path = file_path:gsub("^%/", "")

      if not isempty(filename) then
        local default = false

        if isempty(file_type) then
          file_type = ""
          default = true
        end

        local status_web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
        if status_web_devicons_ok then file_icon = web_devicons.get_icon(filename, file_type, { default = default }) end

        if not file_icon then file_icon = icons.ui.File end

        value = " "

        if true then
          local file_path_list = {}
          local _ = string.gsub(file_path, "[^/]+", function(w) table.insert(file_path_list, w) end)

          for i = 1, #file_path_list do
            value = value .. file_path_list[i] .. " " .. icons.ui.ChevronRight .. " "
          end
        end
        value = value .. filename
      end

      return value
    end,
    padding = 0,
  },
  modicon = {
    function()
      local filename = vim.fn.expand("%:t")
      if not isempty(filename) then
        if vim.bo.modified then
          return icons.ui.Pencil
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return icons.ui.Lock
        else
          return icons.ui.Note
        end
      else
        return ""
      end
    end,
    padding = { left = 1, right = 0 },
    color = function()
      if vim.bo.modified then
        return fg("special")()
      elseif vim.bo.modifiable == false or vim.bo.readonly == true then
        return fg("special")()
      end
    end,
  },
  navic = {
    function()
      local location = require("nvim-navic").get_location()
      if not isempty(location) then
        return icons.ui.ChevronRight .. " " .. location
      else
        return ""
      end
    end,
    cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
  },
}
