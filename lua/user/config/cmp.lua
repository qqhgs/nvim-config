vim.opt.completeopt = "menu,menuone,noselect"

local ok, cmp = pcall(require, "cmp")
if not ok then
  return
end

local present, luasnip = pcall(require, "luasnip")
if not present then
  return
end

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local is_emmet_active = function()
  local clients = vim.lsp.buf_get_clients()

  for _, client in pairs(clients) do
    if client.name == "emmet_ls" then
      return true
    end
  end
  return false
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local formatting = {
  kind_icons = {
    Class = " ",
    Color = " ",
    Constant = "ﲀ ",
    Constructor = " ",
    Enum = "練",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = "",
    Folder = " ",
    Function = " ",
    Interface = "ﰮ ",
    Keyword = " ",
    Method = " ",
    Module = " ",
    Operator = "",
    Property = " ",
    Reference = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    TypeParameter = " ",
    Unit = "塞",
    Value = " ",
    Variable = " ",
  },
  source_names = {
    nvim_lsp = "[Lsp]",
    buffer = "[Buff]",
    luasnip = "[Snip]",
    -- nvim_lua = "[Nvim]",
    -- path = "[Path]",
    cmdline = "[CMD]",
  },
  duplicates = {
    buffer = 1,
    path = 1,
    nvim_lsp = 0,
    luasnip = 1,
  },
}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources {
    { name = "luasnip" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          -- return list of only active buffer
          return vim.tbl_filter(function(buf)
            return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted
          end, vim.api.nvim_list_bufs())
        end,
      },
    },
    { name = "path" },
    { name = "nvim_lsp" },
  },
  completion = {
    keyword_pattern = [[.-*]],
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  formatting = {
    duplicates_default = 1,
    format = function(entry, vim_item)
      vim_item.kind = formatting.kind_icons[vim_item.kind]
      vim_item.menu = formatting.source_names[entry.source.name]
      vim_item.dup = formatting.duplicates[entry.source.name] or formatting.duplicates_default
      return vim_item
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-o>"] = cmp.mapping.confirm { select = true },
    -- ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      elseif is_emmet_active() then
        return vim.fn["cmp#complete"]()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
}

cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
cmp.setup.cmdline(":", { sources = { { name = "cmdline" } } })
