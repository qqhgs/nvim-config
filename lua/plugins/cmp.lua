return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function()
    local cmp = require("cmp")
    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      formatting = {
        format = function(_, vim_item)
          local icons = require("const.icons")
          local kind = icons.kind
          local min_width = 20
          local max_width = 30

          local label = vim_item.abbr
          local truncated_label = vim.fn.strcharpart(label, 0, max_width)
          if truncated_label ~= label then
            vim_item.abbr = truncated_label .. icons.ui.Ellipsis
          elseif string.len(label) < min_width then
            local padding = string.rep(" ", min_width - string.len(label))
            vim_item.abbr = label .. padding
          end

          vim_item.menu = vim_item.kind
          vim_item.kind = kind[vim_item.kind]
          return vim_item
        end,
        fields = { "kind", "abbr", "menu" },
      },
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
    }
  end,
}
