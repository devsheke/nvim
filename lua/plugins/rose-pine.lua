return {
	"rose-pine/neovim",
	name = "rose-pine",
	dependencies = { "xiyaowong/transparent.nvim" },
	config = function()
		require("rose-pine").setup({
			highlight_groups = { SnacksIndent = { fg = "overlay" } },
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
