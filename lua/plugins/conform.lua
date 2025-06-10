return {
	"stevearc/conform.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		formatters_by_ft = { lua = { "stylua" } },
		format_on_save = { timeout_ms = 800, lsp_fallback = true },
	},
}
