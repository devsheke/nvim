local M = {}

M.formatters_by_ft = {
	lua = { "stylua" },
	go = { "gofmt", "goimports-reviser", "golines" },
	javascript = { "prettierd" },
	javascriptreact = { "prettierd" },
	typescript = { "prettierd" },
	typescriptreact = { "prettierd" },
	rust = { "rustfmt" },
	bash = { "beautysh" },
	nix = { "alejandra" },
	python = { "black", "isort" },
	swift = { "swift_format" },
	templ = { "templ", "rustywind" },
}

M.format_on_save = {
	timeout_ms = 800,
	lsp_fallback = true,
}

return M
