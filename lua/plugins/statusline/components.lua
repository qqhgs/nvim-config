local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local icons = require("const.icons")

local ffi = require("ffi")
ffi.cdef([[
	typedef struct {} Error;
	typedef struct {} win_T;
	typedef struct {
		int start;  // line number where deepest fold starts
		int level;  // fold level, when zero other fields are N/A
		int llevel; // lowest level that starts in v:lnum
		int lines;  // number of lines from v:lnum to end of closed fold
	} foldinfo_T;
	foldinfo_T fold_info(win_T* wp, int lnum);
	win_T *find_window_by_handle(int Window, Error *err);
	int compute_foldcolumn(win_T *wp, int col);
]])

local function set_hl(fg_group, opts, reverse)
  opts = opts or {}
  local fg = utils.get_highlight(fg_group).fg
  local bg = utils.get_highlight(fg_group).bg
  local status_bg = utils.get_highlight("Statusline").bg
  local default = { fg = fg, bg = status_bg }
  if reverse then default = { fg = bg, bg = fg } end
  return vim.tbl_deep_extend("force", default, opts)
end

local M = {}

M.Align = { provider = "%=" }
M.Space = { provider = " " }

M.Ruler = {
  provider = " %6(%l/%c%) ",
  hl = { fg = utils.get_highlight("Normal").bg, bg = utils.get_highlight("DiffRemoved").fg },
}
M.Cwd = {
  -- stylua: ignore
  provider = function ()
    local cwd = vim.fn.getcwd(0)
    cwd = vim.fn.fnamemodify(cwd, ":t")
    return string.format(" %s %s ", icons.ui.Folder, cwd)
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

M.Git = {
  condition = conditions.is_git_repo,
  init = function(self)
    self.status_dict = vim.b.gitsigns_status_dict
    self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
  end,
  -- hl = { fg = colors.black, bg = colors.white },
  -- hl = set_hl("Identifier"),
  {
    -- git branch name
    provider = function(self) return string.format(" %s %s ", icons.git.Branch, self.status_dict.head) end,
    hl = set_hl("Identifier"),
  },
  {
    provider = function(self)
      local count = self.status_dict.added or 0
      return count > 0 and string.format("%s %d ", icons.git.LineAdded, count)
    end,
    hl = set_hl("DiffAdded"),
  },
  {
    provider = function(self)
      local count = self.status_dict.removed or 0
      return count > 0 and string.format("%s %d ", icons.git.LineRemoved, count)
    end,
    hl = set_hl("DiffRemoved"),
  },
  {
    provider = function(self)
      local count = self.status_dict.changed or 0
      return count > 0 and string.format("%s %d ", icons.git.LineModified, count)
    end,
    hl = set_hl("DiffChanged"),
  },
}

M.Diagnostics = {
  condition = function() return conditions.lsp_attached() and vim.api.nvim_win_get_width(0) > 80 end,
  -- condition = function() return conditions.has_diagnostics() and vim.api.nvim_win_get_width(0) > 80 end,
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.error })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.warn })
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self) return string.format("%s %s", icons.diagnostics.Warn, self.errors or 0) end,
    hl = function(self)
      if self.errors > 0 then return set_hl("DiagnosticSignError") end
    end,
  },
  M.Space,
  {
    provider = function(self) return string.format("%s %s", icons.diagnostics.Warn, self.warnings or 0) end,
    hl = function(self)
      if self.warnings > 0 then return set_hl("DiagnosticSignWarn") end
    end,
  },
}

M.Vimode = {
  init = function(self) self.mode = vim.fn.mode(1) end,
  static = {
    mode_names = {
      ["n"] = "NORMAL",
      ["no"] = "OP",
      ["nov"] = "OP",
      ["noV"] = "OP",
      ["no"] = "OP",
      ["niI"] = "NORMAL",
      ["niR"] = "NORMAL",
      ["niV"] = "NORMAL",
      ["i"] = "INSERT",
      ["ic"] = "INSERT",
      ["ix"] = "INSERT",
      ["t"] = "TERM",
      ["nt"] = "TERM",
      ["v"] = "VISUAL",
      ["vs"] = "VISUAL",
      ["V"] = "LINES",
      ["Vs"] = "LINES",
      [""] = "BLOCK",
      ["s"] = "BLOCK",
      ["R"] = "REPLACE",
      ["Rc"] = "REPLACE",
      ["Rx"] = "REPLACE",
      ["Rv"] = "V-REPLACE",
      ["s"] = "SELECT",
      ["S"] = "SELECT",
      [""] = "BLOCK",
      ["c"] = "COMMAND",
      ["cv"] = "COMMAND",
      ["ce"] = "COMMAND",
      ["r"] = "PROMPT",
      ["rm"] = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
      ["null"] = "null",
    },
    mode_colors = {
      n = "DiffAdded",
      i = "DiagnosticSignError",
      v = "DiagnosticSignInfo",
      V = "DiagnosticSignInfo",
      ["\22"] = "DiagnosticSignInfo",
      c = "Function",
      s = "Constant",
      S = "Constant",
      ["\19"] = "Constant",
      R = "Function",
      r = "Function",
      ["!"] = "Delimiter",
      t = "Delimiter",
    },
  },
  -- stylua: ignore
  provider = function (self)
        -- return " %2("..self.mode_names[self.mode].."%)"
    return string.format("  %s ", self.mode_names[self.mode])
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = utils.get_highlight("Normal").bg, bg = utils.get_highlight(self.mode_colors[mode]).fg }
  end,
  update = {
    "ModeChanged",
    pattern = "*:*",
    callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
  },
}

M.SearchCount = {
  condition = function() return vim.v.hlsearch ~= 0 and vim.o.cmdheight == 0 end,
  init = function(self)
    local ok, search = pcall(vim.fn.searchcount)
    if ok and search.total then self.search = search end
  end,
  provider = function(self)
    local search = self.search
    return string.format("%s [%d/%d]", icons.ui.Search, search.current, math.min(search.total, search.maxcount))
  end,
}

M.FileIcon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self) return self.icon and (self.icon .. " ") end,
  hl = function(self) return { fg = self.icon_color } end,
}

M.FileName = {
  provider = function()
    -- local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
    local filename = vim.fn.expand("%:t")
    if filename == "" then return "[No Name]" end
    if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
    return filename
  end,
  -- hl = { fg = utils.get_highlight("Directory").fg },
}

M.FileFlags = {
  { condition = function() return vim.bo.modified end, provider = icons.ui.Pencil, hl = set_hl("DiffAdded") },
  {
    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
    provider = icons.ui.Lock,
    hl = set_hl("DiffChanged"),
  },
}

M.Breadcrumbs = {
  provider = function()
    local filepath = vim.fn.expand("%:~:.:h")
    filepath = filepath:gsub("^%.", "")
    filepath = filepath:gsub("^%/", "")

    local file_path_list = {}
    local _ = string.gsub(filepath, "[^/]+", function(w) table.insert(file_path_list, w) end)

    if #file_path_list > 0 then
      local separator = string.format(" %s ", icons.ui.ChevronRight)
      return table.concat(file_path_list, separator) .. separator
    end
  end,
  M.FileIcon,
  M.FileName,
  M.Space,
  M.FileFlags,
}

M.FileEncoding = {
  provider = function()
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    return enc ~= "utf-8" and enc:upper()
  end,
}

M.FileType = {
  provider = function() return string.upper(vim.bo.filetype) end,
}

M.Toggleterm = {
  condition = function() return conditions.buffer_matches({ filetype = { "toggleterm" } }) end,
  provider = function() return string.format(" ToggleTerm %s ", vim.b.toggle_number) end,
  hl = { fg = utils.get_highlight("Normal").bg, bg = utils.get_highlight("DiffAdded").fg },
}

M.NvimTree = {
  condition = function() return conditions.buffer_matches({ filetype = { "NvimTree" } }) end,
  provider = " Explorer ",
  hl = { fg = utils.get_highlight("Normal").bg, bg = utils.get_highlight("DiffAdded").fg },
}

M.Outline = {
  condition = function() return conditions.buffer_matches({ filetype = { "Outline" } }) end,
  provider = " Outline ",
  hl = { fg = utils.get_highlight("Normal").bg, bg = utils.get_highlight("DiffAdded").fg },
}

M.LSP = {
  condition = conditions.lsp_attached,
  update = { "LspAttach", "LspDetach", "BufEnter" },
  provider = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return string.format(" %s [%s]", icons.ui.Gear2, table.concat(names, ", "))
  end,
  hl = set_hl("DiffAdded"),
}

M.Treesitter = {
  condition = function()
    local buf = vim.api.nvim_get_current_buf()
    local ts = vim.treesitter.highlighter.active[buf]
    return ts
  end,
  provider = icons.ui.Tree2 .. " ",
  hl = set_hl("DiffChanged"),
}

M.Numbercolumn = {
  condition = function() return vim.opt.number:get() or vim.opt.relativenumber:get() end,
  provider = function()
    if vim.opt.relativenumber:get() then return "%r " end
    return "%l"
  end,
}

M.Signcolumn = {
  provider = "%s",
}

M.Foldcolumn = {
  condition = function() return vim.opt.foldcolumn:get() ~= 0 end,
  -- provider = "%C",
  provider = function()
    local wp = ffi.C.find_window_by_handle(0, ffi.new("Error")) -- get window handler
    local width = ffi.C.compute_foldcolumn(wp, 0) -- get foldcolumn width
    -- get fold info of current line
    local foldinfo = width > 0 and ffi.C.fold_info(wp, vim.v.lnum) or { start = 0, level = 0, llevel = 0, lines = 0 }

    local str = ""
    if width ~= 0 then
      str = vim.v.relnum > 0 and "%#FoldColumn#" or "%#CursorLineFold#"
      if foldinfo.level == 0 then
        str = str .. (" "):rep(width)
      else
        local closed = foldinfo.lines > 0
        local first_level = foldinfo.level - width - (closed and 1 or 0) + 1
        if first_level < 1 then first_level = 1 end

        for col = 1, width do
          str = str
            .. (
              ((closed and (col == foldinfo.level or col == width)) and icons.ui.FoldClosed)
              or ((foldinfo.start == vim.v.lnum and first_level + col > foldinfo.llevel) and icons.ui.FoldOpen)
              or " "
            )
          if col == foldinfo.level then
            str = str .. (" "):rep(width - col)
            break
          end
        end
      end
    end
    return str .. "%* "
  end,
}

return M
