local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	check_git_workspace = function()
		local filepath = vim.fn.expand("%:p:h")
		local gitdir = vim.fn.finddir(".git", filepath .. ";")
		return gitdir and #gitdir > 0 and #gitdir < #filepath
	end,
	check_diagnostics_available = function()
		return #vim.diagnostic.get(0) > 0
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "rose-pine/neovim" },
	opts = function()
		local colors = require("rose-pine.palette")

		local opts = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = {
					normal = { c = { fg = colors.text, bg = colors.overlay } },
					inactive = { c = { fg = colors.text, bg = colors.surface } },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		local function ins_left(component)
			table.insert(opts.sections.lualine_c, component)
		end

		local function ins_right(component)
			table.insert(opts.sections.lualine_x, component)
		end

		local function add_seperator(pos, cond)
			local sep = {
				function()
					return "|"
				end,
				cond = cond,
				color = { fg = colors.highlight_high },
				padding = { left = 1, right = 1 },
			}

			if pos == "right" then
				ins_right(sep)
			elseif pos == "left" then
				ins_left(sep)
			end
		end

		ins_left({
			function()
				return "▊"
			end,
			color = { fg = colors.teal },
			padding = { left = 0, right = 0 },
		})

		local mode_color = {
			n = colors.foam,
			no = colors.foam,
			i = colors.rose,
			ic = colors.rose,
			v = colors.iris,
			[""] = colors.iris,
			V = colors.iris,
			c = colors.gold,
			cv = colors.gold,
			ce = colors.gold,
			s = colors.muted,
			S = colors.muted,
			[""] = colors.muted,
			R = colors.love,
			Rv = colors.love,
			r = colors.gold,
			rm = colors.gold,
			["r?"] = colors.gold,
			["!"] = colors.gold,
		}

		ins_left({
			"mode",
			color = function()
				return { bg = mode_color[vim.fn.mode()], fg = colors.base, gui = "bold" }
			end,
			padding = { left = 1 },
		})

		ins_left({
			function()
				return ""
			end,
			color = function()
				return { fg = mode_color[vim.fn.mode()] }
			end,
			padding = { right = 1 },
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.iris, gui = "bold" },
		})

		add_seperator("left", function()
			return conditions.buffer_not_empty()
				and (conditions.check_git_workspace() or conditions.check_diagnostics_available())
		end)

		ins_left({
			"branch",
			icon = "",
			color = { fg = colors.love, gui = "bold" },
		})

		ins_left({
			"diff",
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			diff_color = {
				added = { fg = colors.foam },
				modified = { fg = colors.gold },
				removed = { fg = colors.rose },
			},
			cond = conditions.hide_in_width,
		})

		add_seperator("left", function()
			return conditions.check_git_workspace() and conditions.check_diagnostics_available()
		end)

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
			diagnostics_color = {
				color_error = { fg = colors.love },
				color_warn = { fg = colors.gold },
				color_info = { fg = colors.pine },
			},
		})

		ins_right({
			"o:encoding",
			cond = conditions.hide_in_width,
			color = { fg = colors.muted, gui = "bold" },
			padding = { right = 1 },
		})

		add_seperator("right", conditions.hide_in_width)

		ins_right({
			function()
				local msg = "null"
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " :",
			color = { fg = colors.foam, gui = "bold" },
			padding = { left = 1, right = 1 },
		})

		add_seperator("right")

		ins_right({ "location" })

		ins_right({
			function()
				return "▊"
			end,
			color = { fg = colors.foam },
			padding = { right = 0 },
		})

		return opts
	end,
}
