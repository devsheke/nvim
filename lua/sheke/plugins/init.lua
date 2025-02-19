local buf_open_events = { "BufReadPost", "BufNewFile" }

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = false,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},

	{ "xiyaowong/transparent.nvim" },

	{
		"nvim-treesitter/nvim-treesitter",
		event = buf_open_events,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("sheke.plugins.config.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			return require("sheke.plugins.config.lspconfig"):defaults()
		end,
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{ "onsails/lspkind.nvim", lazy = true },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = "rafamadriz/friendly-snippets",
				opts = { history = true, updateevents = "TextChanged,TextChangedI" },
				config = function(_, opts)
					require("luasnip").config.set_config(opts)
				end,
			},

			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)

					-- setup cmp for autopairs
					local cmp_autopairs = require("nvim-autopairs.completion.cmp")
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
			},

			{
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
		},

		opts = function()
			return require("sheke.plugins.config.cmp")
		end,
		config = function(_, opts)
			require("cmp").setup(opts)
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = buf_open_events,
		opts = function()
			return require("sheke.plugins.config.gitsigns")
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = require("sheke.plugins.config.lualine"),
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	{
		"stevearc/conform.nvim",
		event = buf_open_events,
		opts = require("sheke.plugins.config.conform"),
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		opts = require("sheke.plugins.config.noice"),
		config = function(_, opts)
			require("noice").setup(opts)
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = buf_open_events,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			local comment = require("Comment")
			local ts_context_commentstring =
				require("ts_context_commentstring.integrations.comment_nvim")
			comment.setup({
				-- for commenting tsx, jsx, svelte, html files
				pre_hook = ts_context_commentstring.create_pre_hook(),
			})
		end,
	},

	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = require("sheke.plugins.config.snacks").opts,
		keys = require("sheke.plugins.config.snacks").keys,
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function(_, _)
			require("trouble").setup({ focus = true })
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},

	{
		"nvim-neorg/neorg",
		cmd = "Neorg",
		version = "*", -- Pin Neorg to the latest stable release
		opts = require("sheke.plugins.config.neorg"),
		config = function(_, opts)
			require("neorg").setup(opts)
		end,
	},
}
