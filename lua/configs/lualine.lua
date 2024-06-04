local colors = {
	fg = "#e0def4",
	bg = "#26233a",
	darkblue = "#9ccfd8",
	orange = "#eb6f92",
	violet = "#c4a7e7",
	black = "#26233a",
	red = "#eb6f92",
	green = "#31748f",
	yellow = "#f6c177",
	blue = "#9ccfd8",
	magenta = "#c4a7e7",
	cyan = "#ebbcba",
	white = "#e0def4",
}

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
}

local options = {
	options = {
		component_separators = "",
		section_separators = "",
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
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
	table.insert(options.sections.lualine_c, component)
end

local function ins_right(component)
	table.insert(options.sections.lualine_x, component)
end

ins_left({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 0, right = 0 },
})

ins_left({
	"mode",
	color = function()
		local mode_color = {
			n = colors.red,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.magenta,
			no = colors.red,
			s = colors.orange,
			S = colors.orange,
			[""] = colors.orange,
			ic = colors.yellow,
			R = colors.violet,
			Rv = colors.violet,
			cv = colors.red,
			ce = colors.red,
			r = colors.cyan,
			rm = colors.cyan,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}
		return { bg = mode_color[vim.fn.mode()], fg = "#000000", gui = "bold" }
	end,
	padding = { right = 1, left = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = "bold" },
})

ins_left({
	"branch",
	icon = "",
	color = { fg = colors.violet, gui = "bold" },
})

ins_left({
	"diff",
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.orange },
		removed = { fg = colors.red },
	},
	cond = conditions.hide_in_width,
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.red },
		color_warn = { fg = colors.yellow },
		color_info = { fg = colors.cyan },
	},
})

ins_right({
	function()
		local msg = "null"
		local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
		local clients = vim.lsp.get_active_clients()
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
	color = { fg = colors.blue, gui = "bold" },
})

ins_right({
	"o:encoding",
	cond = conditions.hide_in_width,
	color = { fg = colors.green, gui = "bold" },
})

ins_right({ "location" })

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.blue },
	padding = { left = 1 },
})

return options
