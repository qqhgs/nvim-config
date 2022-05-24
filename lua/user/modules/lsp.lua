require("nvim-lsp-installer").setup {}
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local configs = {
	sign = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
	keymaps = {
		["<Leader>la"] = ":lua vim.lsp.buf.code_action()<CR>",
		["<Leader>lc"] = ":lua vim.lsp.buf.references()<CR>",
		["<Leader>ld"] = ":lua vim.lsp.buf.definition()<CR>",
		["<Leader>le"] = ":lua vim.lsp.buf.declaration()<CR>",
		["<Leader>lf"] = ":lua vim.lsp.buf.formatting()<CR>",
		["<Leader>lF"] = ":LspToggleAutoFormat<CR>",
		["<Leader>lh"] = ":lua vim.lsp.buf.hover()<CR>",
		["<Leader>li"] = ":LspInfo<CR>",
		["<Leader>lr"] = ":lua vim.lsp.buf.rename()<CR>",
		["<Leader>lR"] = ":LspRestart<CR>",
		["<Leader>ls"] = ":lua vim.lsp.buf.signature_help()<CR>",
		["<Leader>lq"] = ":lua vim.diagnostic.setloclist()<CR>",
	},
	setup = {
		virtual_text = false,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	},
}

local sign = configs.sign
vim.fn.sign_define("DiagnosticSignError", { text = sign.error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = sign.warn, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignHint", { text = sign.hint, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignInfo", { text = sign.info, texthl = "DiagnosticSignError" })

vim.diagnostic.config(configs.setup)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})
local function highlight_document(client)
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
			false
		)
	end
end

local function keymaps(bufnr)
	for lhs, rhs in pairs(configs.keymaps) do
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_settings = {
	on_attach = {
		["tsserver"] = function(client)
			client.resolved_capabilities.document_formatting = false
		end,
	},
	servers = {
		["sumneko_lua"] = {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand "$VIMRUNTIME/lua"] = true,
							vim.api.nvim_get_runtime_file("", true),
							[vim.fn.stdpath "config" .. "/lua"] = true,
						},
						maxPreload = 100000,
						preloadFileSize = 10000,
					},
				},
			},
		},
		["gopls"] = {
			cmd = { "gopls", "serve" },
			filetypes = { "go", "gomod" },
			root_dir = util.root_pattern("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					-- analyses = {
					-- unusedparams = true,
					-- },
					-- staticcheck = true,
					-- usePlaceholders = false,
					memoryMode = "DegradeClosed",
				},
			},
		},
		["emmet_ls"] = {
			filetypes = { "html", "css", "typescriptreact", "javascriptreact", "svelte" },
		},
		["html"] = {},
		["cssls"] = {},
		["tailwindcss"] = {},
		["jsonls"] = {},
		["tsserver"] = {},
		["clangd"] = {},
	},
}

local function on_attach(client, bufnr)
	if lsp_settings ~= nil then
		for key, callback in pairs(lsp_settings.on_attach or {}) do
			if client.name == key then
				callback(client)
			end
		end
	end
	keymaps(bufnr)
	highlight_document(client)
end

if lsp_settings ~= nil then
	for name, config in pairs(lsp_settings.servers) do
		local opts = { on_attach = on_attach, capabilities = capabilities }
		opts = vim.tbl_deep_extend("force", config, opts)
		lspconfig[name].setup(opts)
	end
end
