local lsp = {}

lsp.servers = {
	"basedpyright",
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
	"rust_analyzer",
	"svelte",
	"tailwindcss",
	"taplo",
	"ts_ls",
}

lsp.capabilites = vim.lsp.protocol.make_client_capabilities()

lsp.capabilites.textDocument.completion.completionItem = {
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

local map = vim.keymap.set
lsp.on_attach = function(_, bufrn)
	local function opts(desc)
		return { buffer = bufrn, desc = "LSP " .. desc }
	end

	map("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
	map("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
	map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
	map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))

	map("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts("List workspace folders"))

	map("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
end

lsp.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				lsp.on_attach(args.buf)
			end,
		})

		vim.lsp.config("*", { capabilities = lsp.capabilites, on_init = lsp.on_init })

		for _, lsp_name in ipairs(lsp.servers) do
			local status, config = pcall(require, "config.lsp." .. lsp_name)
			if not status then
				vim.lsp.config(lsp_name, {})
				vim.lsp.enable(lsp_name)
			else
				config:default()
			end
		end

		vim.diagnostic.config({
			float = { border = "rounded", source = true },
			severity_sort = true,
			virtual_text = true,
			underline = true,
			update_in_insert = false,
		})
	end,
}
