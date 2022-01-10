local ready, _ = pcall(require, "lspconfig")
if not ready then
	return
end

local installer_present, installer = pcall(require, "nvim-lsp-installer")
if not installer_present then
	return
end

local function set_sign(name, text)
	vim.fn.sign_define(name, { text = text, texthl = name })
end
set_sign("DiagnosticSignError", "")
set_sign("DiagnosticSignWarn", "")
set_sign("DiagnosticSignHint", "")
set_sign("DiagnosticSignInfo", "")

vim.diagnostic.config({
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
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

local keybindings = {
	["<Leader>la"] = ":lua vim.lsp.buf.code_action()<CR>",
	["<Leader>lc"] = ":lua vim.lsp.buf.references()<CR>",
	["<Leader>ld"] = ":lua vim.lsp.buf.definition()<CR>",
	["<Leader>le"] = ":lua vim.lsp.buf.declaration()<CR>",
	["<Leader>lf"] = ":lua vim.lsp.buf.formatting()<CR>",
	["<Leader>lF"] = ":LspToggleAutoFormat<CR>",
	["<Leader>lh"] = ":lua vim.lsp.buf.hover()<CR>",
	["<Leader>li"] = ":LspInfo<CR>",
	["<Leader>ll"] = ":vim.lsp.diagnostic.show_line_diagnostics({ border = 'rounded' })<CR>",
	["<Leader>lm"] = ":lua vim.lsp.buf.implementation()<CR>",
	["<Leader>lr"] = ":lua vim.lsp.buf.rename()<CR>",
	["<Leader>ls"] = ":lua vim.lsp.buf.signature_help()<CR>",
}

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

local function custom_on_attach(client, bufnr)
	for lhs, rhs in pairs(keybindings) do
		vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
	end

	-- if client.name == "tsserver" then
	-- 	client.resolved_capabilities.document_formatting = false
	-- end

	highlight_document(client)
end

local custom_capabilities = vim.lsp.protocol.make_client_capabilities()
custom_capabilities.textDocument.completion.completionItem.snippetSupport = true

local present, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not present then
	return
end

custom_capabilities = cmp_nvim_lsp.update_capabilities(custom_capabilities)

installer.on_server_ready(function(server)
	local opts = {
		on_attach = custom_on_attach,
		capabilities = custom_capabilities,
	}

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "pyright" then
		local pyright_opts = require("config.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	server:setup(opts)
end)
