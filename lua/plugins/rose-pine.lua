return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			highlight_groups = { SnacksIndent = { fg = "overlay" } },
		})
		vim.cmd("colorscheme rose-pine")
	end,
}
