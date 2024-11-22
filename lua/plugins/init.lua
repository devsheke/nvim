local buf_open_events = { "BufReadPost", "BufNewFile" }

return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = buf_open_events,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			return require("configs.lspconfig").defaults()
		end,
	},

	{ "onsails/lspkind.nvim" },

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
					require("configs.luasnip")
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
			return require("configs.cmp")
		end,
		config = function(_, opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			cmp.setup(opts)
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports-reviser", "golines" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				rust = { "rustfmt" },
				bash = { "beautysh" },
				nix = { "alejandra" },
				python = { "black", "isort" },
				swift = { "swift_format" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		opts = function()
			return require("configs.telescope")
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			return require("configs.lualine")
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = buf_open_events,
		main = "ibl",
		opts = { indent = { char = "▏" } },
	},

	{
		"lewis6991/gitsigns.nvim",
		event = buf_open_events,
		opts = function()
			return require("configs.gitsigns")
		end,
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function(_, opts)
			require("trouble").setup(opts)
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = buf_open_events,
	},

	{
		"vhyrro/luarocks.nvim",
		opts = {
			rocks = { "lua-utils.nvim", "pathlib.nvim" },
		},
		priority = 1000,
		config = true,
	},

	{
		"nvim-neorg/neorg",
		cmd = "Neorg",
		version = "*",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = { config = { icon_preset = "diamond" } },
					["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
					["core.integrations.nvim-cmp"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Documents/Notes",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				variant = "dawn",
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}
