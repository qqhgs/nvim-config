local cmp_ready, cmp = pcall(require, "cmp")
if not cmp_ready then
  return
end

vim.opt.completeopt = "menuone,noselect"

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local snip_ready, luasnip = pcall(require, "luasnip")
if not snip_ready then
  return
end

local configs = {
  sources = {
    { name = "nvim_lsp" },
    -- { name = "nvim_lua" },
    {
      name = "buffer",
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = "path" },
    { name = "cmdline" },
    { name = "luasnip" },
  },
  source_names = {
    nvim_lsp = "[Lsp]",
    -- nvim_lua = "[Nvim]",
    buffer = "[Buff]",
    path = "[Path]",
    cmdline = "[CMD]",
    luasnip = "[Snip]",
  },
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
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-o>"] = cmp.mapping.confirm { select = true },
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
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

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = configs.kind_icons[vim_item.kind]
      vim_item.menu = configs.source_names[entry.source.name]
      return vim_item
    end,
  },
  mapping = configs.mapping,
  sources = configs.sources,
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
}

cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
cmp.setup.cmdline(":", { sources = { { name = "cmdline" } } })
