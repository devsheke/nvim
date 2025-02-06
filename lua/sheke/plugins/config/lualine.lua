local colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
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
			normal = { c = { fg = colors.text, bg = colors.mantle } },
			inactive = { c = { fg = colors.text, bg = colors.mantle } },
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
	color = { fg = colors.teal },
	padding = { left = 0, right = 0 },
})

local mode_color = {
	n = colors.red,
	i = colors.green,
	v = colors.mauve,
	[""] = colors.lavender,
	V = colors.sapphire,
	c = colors.pink,
	no = colors.flamingo,
	s = colors.yellow,
	S = colors.yellow,
	[""] = colors.yellow,
	ic = colors.yellow,
	R = colors.red,
	Rv = colors.red,
	cv = colors.red,
	ce = colors.red,
	r = colors.rosewater,
	rm = colors.rosewater,
	["r?"] = colors.rosewater,
	["!"] = colors.flamingo,
	t = colors.flamingo,
}

ins_left({
	"mode",
	color = function()
		return { bg = mode_color[vim.fn.mode()], fg = colors.mantle, gui = "bold" }
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
	color = { fg = colors.sky, gui = "bold" },
})

ins_left({
	"branch",
	icon = "",
	color = { fg = colors.red, gui = "bold" },
})

ins_left({
	"diff",
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colors.peach },
		modified = { fg = colors.peach },
		removed = { fg = colors.flamingo },
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
		color_info = { fg = colors.green },
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
	color = { fg = colors.sapphire, gui = "bold" },
})

ins_right({
	"o:encoding",
	cond = conditions.hide_in_width,
	color = { fg = colors.overlay0, gui = "bold" },
})

ins_right({ "location" })

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.teal },
	padding = { left = 1 },
})

return options
