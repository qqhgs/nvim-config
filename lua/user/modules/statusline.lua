local present, lualine = pcall(require, "lualine")
if not present then
  return
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local conds = {
  hide_in_width = function()
    return vim.fn.winwidth(0) > 70
  end,
}
local components = {
  mode = {
    "mode",
    cond = conds.hide_in_width,
  },
  filename = {
    "filename",
    symbols = {
      modified = " ",
      readonly = " ",
    },
  },
  filesize = {
    "filesize",
    cond = conds.hide_in_width,
  },
  location = {
    "location",
    cond = conds.hide_in_width,
  },
  encoding = {
    "encoding",
    cond = conds.hide_in_width,
  },
  branch = {
    "branch",
    icons_enabled = true,
    icon = "",
  },
  diff = {
    "diff",
    source = diff_source,
    -- colored = false,
    symbols = { added = " ", modified = " ", removed = " " },
    cond = conds.hide_in_width,
  },
  treesitter = {
    function()
      local b = vim.api.nvim_get_current_buf()
      if next(vim.treesitter.highlighter.active[b]) then
        return ""
      end
      return ""
    end,
    cond = conds.hide_in_width,
  },
  lsp = {
    function()
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) then
        return " "
      end
      return ""
    end,
    -- icon = " ",
    cond = conds.hide_in_width,
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    -- colored = false,
    update_in_insert = false,
    always_visible = true,
    cond = conds.hide_in_width,
  },
}

local configs = {
  options = {
		globalstatus = 3,
    section_separators = { left = " ", right = " " },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { "NvimTree", "alpha" },
    theme = "auto",
  },
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
      components.diff,
    },
    lualine_c = {
      components.filename,
    },
    lualine_x = {
      components.treesitter,
      components.lsp,
      "filetype",
    },
    lualine_y = {
      components.diagnostics,
    },
    lualine_z = {
      components.location,
    },
  },
}

lualine.setup(configs)
