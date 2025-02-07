local cmp = require("cmp_nvim_lsp")
local lspconfig = require("lspconfig")

local lang_servers = {
	"bashls",
	"clangd",
	"cssls",
	"dockerls",
	"eslint",
	"golangci_lint_ls",
	"gopls",
	"html",
	"jsonls",
	"lua_ls",
	"nil_ls",
	"pylsp",
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"taplo",
	"templ",
	"ts_ls",
	"zls",
}

local M = {}

M.capabilities = cmp.default_capabilities()
M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.on_attach = function(_, bufnr)
	local function opts(desc)
		return { buffer = bufnr, desc = "Lsp " .. desc }
	end

	local map = vim.keymap.set

	map("n", "gd", vim.lsp.buf.declaration, opts("go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("go to definition"))
	map("n", "K", vim.lsp.buf.hover, opts("hover information"))
	map("n", "gi", vim.lsp.buf.implementation, opts("go to implementation"))
	map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("show signature help"))
	map("n", "<leader>rn", vim.lsp.buf.rename, opts("rename symbol"))
	map("n", "<leader>d", vim.lsp.buf.type_definition, opts("go to type definition"))
	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("code action"))
	map("n", "gr", vim.lsp.buf.references, opts("show references"))
	map("n", "<leader>vd", vim.diagnostic.open_float, opts("open diagnostics float"))
	map("n", "[d", vim.diagnostic.goto_next, opts("go to next diagnostics report"))
	map("n", "]d", vim.diagnostic.goto_prev, opts("go to prev diagnostics report"))
end

M.on_init = function(client, _)
	if client.supports_method("textdocument/semantictokens") then
		client.server_capabilities.semantictokensprovider = nil
	end
end

M.defaults = function(self)
	local border = {
		{ "╭", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╮", "FloatBorder" },
		{ "│", "FloatBorder" },
		{ "╯", "FloatBorder" },
		{ "─", "FloatBorder" },
		{ "╰", "FloatBorder" },
		{ "│", "FloatBorder" },
	}

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	for _, server in ipairs(lang_servers) do
		lspconfig[server].setup({
			capabilities = self.capabilities,
			on_attach = self.on_attach,
			on_init = self.on_init,
		})
	end

	lspconfig.lua_ls.setup({
		capabilities = self.capabilities,
		on_attach = self.on_attach,
		on_init = self.on_init,
		settings = {
			lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					maxpreload = 100000,
					preloadfilesize = 10000,
				},
			},
		},
	})

	lspconfig.tailwindcss.setup({
		capabilities = self.capabilities,
		on_attach = on_attach,
		on_init = on_init,
		settings = {
			tailwindcss = {
				experimental = {
					classregex = {
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
						{ "twMerge\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
					},
				},
			},
		},
	})

	vim.filetype.add({ extension = { templ = "templ" } })
	lspconfig.html.setup({
		capabilities = self.capabilities,
		on_attach = self.on_attach,
		on_init = self.on_init,
		filetypes = { "html", "templ" },
	})
end

return M
