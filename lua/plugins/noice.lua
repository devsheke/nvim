return {
	"folke/noice.nvim",
	event = "VeryLazy",
	disable = true,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},

		cmdline = {
			view = "cmdline",
			format = {
				cmdline = { pattern = "^:", icon = "", lang = "vim" },
				search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
				search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
				lua = {
					pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" },
					icon = "",
					lang = "lua",
				},
				help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
				input = { view = "cmdline", icon = "󰥻 " }, -- Used by input()
				-- lua = false, -- to disable a format, set to `false`
			},
		},

		notify = {
			backend = "snacks",
		},

		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = false, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},

		views = {
			hover = {
				view = "popup",
				relative = "cursor",
				focusable = true,
				zindex = 45,
				enter = false,
				anchor = "auto",
				size = {
					width = "auto",
					height = "auto",
					max_height = 20,
					max_width = 120,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				position = { row = 2, col = 0 },
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:None",
					wrap = true,
					linebreak = true,
				},
			},
		},
	},
}
