local icons = require("user.config.icons")
local status_web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")

local hl_winbar_path = "WinBarPath"
local hl_winbar_file = "WinBarFile"
local hl_winbar_file_icon = "WinBarFileIcon"

local configs = {
  show_file_path = true,
  show_symbols = true,

  colors = {
    path = "",
    file_name = "",
    symbols = "",
  },
  exclude_filetype = {
    "help",
    "packer",
    "NvimTree",
    "neo-tree",
    "Trouble",
    "alpha",
    "toggleterm",
    "qf",
    "startuptime",
  },
}

local excludes = function()
  if vim.tbl_contains(configs.exclude_filetype, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end

  return false
end

local isempty = function(s) return s == nil or s == "" end

local function get_location()
  local nvc_present, navic = pcall(require, "nvim-navic")
  if nvc_present then
    local location = navic.get_location()
    if not isempty(location) then
      return " " .. icons.ui.ChevronRight .. " " .. location
    else
      return ""
    end
  end
  return ""
end

local winbar_filepath = function()
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

    if status_web_devicons_ok then
      file_icon = web_devicons.get_icon(filename, file_type, { default = default })
      hl_winbar_file_icon = "DevIcon" .. file_type
    end

    if not file_icon then file_icon = icons.winbar.FileIcon end

    file_icon = "%#" .. hl_winbar_file_icon .. "#" .. file_icon .. " %*"

    value = " "
    if configs.show_file_path then
      local file_path_list = {}
      local _ = string.gsub(file_path, "[^/]+", function(w) table.insert(file_path_list, w) end)

      for i = 1, #file_path_list do
        value = value .. "%#" .. hl_winbar_path .. "#" .. file_path_list[i] .. " " .. icons.ui.ChevronRight .. " %*"
      end
    end
    value = value .. file_icon
    value = value .. "%#" .. hl_winbar_file .. "#" .. filename .. "%*"
  end

  return value
end

vim.api.nvim_create_autocmd({ "DirChanged", "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  callback = function()
    if excludes() then return end

    local location = winbar_filepath()
    if get_location() ~= "" then location = location .. get_location() end
    -- local value = require("user.config.wbar").get_winbar()

    local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", location, { scope = "local" })
    if not status_ok then return end
  end,
})
