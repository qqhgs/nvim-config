return {
  ["gopls"] = {},
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            vim.api.nvim_get_runtime_file("", true),
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    },
  },
  ["emmet_ls"] = {
    filetypes = { "html", "css", "typescriptreact", "javascriptreact", "svelte" },
  },
}
