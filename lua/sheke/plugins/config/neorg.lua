local M = {}

M.load = {
	["core.defaults"] = {},
	["core.completion"] = {
		config = {
			engine = "nvim-cmp",
		},
	},
	["core.concealer"] = {},
	["core.dirman"] = {
		config = {
			workspaces = {
				notes = "~/Documents/Notes",
				journal = "~/Documents/Notes/Journal",
			},
		},
	},
	["core.integrations.treesitter"] = {
		config = {
			install_parsers = false, -- handled by nix
		},
	},
}

return M
