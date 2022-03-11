return {
  normal_mode = {
    -- I never use macros and more often mis-hit this key
    ["q"] = "<Nop>",

    -- I never use Ex-mode too
    ["Q"] = ":qa<CR>",
    ["gQ"] = "<Nop>",

    -- Replace all word on cursor in buffer
    ["<Leader>r"] = { ":%s/\\<<C-R><C-W>\\>\\C//g<left><left>", { noremap = true } },
  },
  insert_mode = {
    -- Navigation
    ["<C-k>"] = "<Up>",
    ["<C-l>"] = "<Right>",
    ["<C-j>"] = "<Down>",
    ["<C-h>"] = "<Left>",
    ["<C-f>"] = "<esc>I",
    ["<C-a>"] = "<esc>A",
    ["<C-e>"] = "<esc>ea",
    ["<C-b>"] = "<esc>bi",
    ["<C-d>"] = "<BS>",
    ["<C-s>"] = "<Del>",
  },
}
