local map = vim.keymap.set
local lspconfig = require("lspconfig")

local servers = {
	"bashls",
	"cssls",
	"clangd",
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
	"tsserver",
}

local options = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(_, bufnr)
		local function opts(desc)
			return { buffer = bufnr, desc = "LSP " .. desc }
		end

		map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
		map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
		map("n", "K", vim.lsp.buf.hover, opts("Hover information"))
		map("n", "gi", vim.lsp.buf.implementation, opts("Go to implementation"))
		map("n", "<leader>sh", vim.lsp.buf.signature_help, opts("Show signature help"))
		map("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename symbol"))
		map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
		map("n", "gr", vim.lsp.buf.references, opts("Show references"))
		map("n", "<leader>vd", vim.diagnostic.open_float, opts("Open diagnostics float"))
		map("n", "[d", vim.diagnostic.goto_next, opts("Go to next diagnostics report"))
		map("n", "]d", vim.diagnostic.goto_prev, opts("Go to prev diagnostics report"))
	end,

	on_init = function(client, _)
		if client.supports_method("textDocument/semanticTokens") then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
}

options.capabilities.textDocument.completion.completionItem = {
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

options.defaults = function()
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		opts.max_width = opts.max_width or 80
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	for _, server in ipairs(servers) do
		lspconfig[server].setup({
			on_attach = options.on_attach,
			capabilities = options.capabilities,
			on_init = options.on_init,
		})
	end

	lspconfig.lua_ls.setup({
		on_attach = options.on_attach,
		capabilities = options.capabilities,
		on_init = options.on_init,

		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	})

	lspconfig.tailwindcss.setup({
		settings = {
			tailwindCSS = {
				experimental = {
					classRegex = {
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "tv\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
					},
				},
			},
		},
	})

	vim.filetype.add({ extension = { templ = "templ" } })
	lspconfig.html.setup({
		on_attach = options.on_attach,
		capabilities = options.capabilities,
		on_init = options.on_init,
		filetypes = { "html", "templ" },
	})
end

return options
