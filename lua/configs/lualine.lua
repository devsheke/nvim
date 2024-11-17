local colors = {
	base = "#faf4ed",
	surface = "#fffaf3",
	overlay = "#f2e9e1",
	muted = "#9893a5",
	subtle = "#797593",
	text = "#575279",
	love = "#b4637a",
	gold = "#ea9d34",
	rose = "#d7827e",
	pine = "#286983",
	foam = "#56949f",
	iris = "#907aa9",
	leaf = "#6d8f89",
	highlight_low = "#f4ede8",
	highlight_med = "#dfdad9",
	highlight_high = "#cecacd",
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
			normal = { c = { fg = colors.text, bg = colors.overlay } },
			inactive = { c = { fg = colors.text, bg = colors.overlay } },
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
	color = { fg = colors.foam },
	padding = { left = 0, right = 0 },
})

ins_left({
	"mode",
	color = function()
		local mode_color = {
			n = colors.love,
			i = colors.pine,
			v = colors.foam,
			[""] = colors.foam,
			V = colors.foam,
			c = colors.iris,
			no = colors.love,
			s = colors.gold,
			S = colors.gold,
			[""] = colors.gold,
			ic = colors.gold,
			R = colors.love,
			Rv = colors.love,
			cv = colors.love,
			ce = colors.love,
			r = colors.rose,
			rm = colors.rose,
			["r?"] = colors.rose,
			["!"] = colors.love,
			t = colors.love,
		}
		return { bg = mode_color[vim.fn.mode()], fg = colors.highlight_low, gui = "bold" }
	end,
	padding = { right = 1, left = 1 },
})

ins_left({
	"filename",
	cond = conditions.buffer_not_empty,
	color = { fg = colors.iris, gui = "bold" },
})

ins_left({
	"branch",
	icon = "",
	color = { fg = colors.love, gui = "bold" },
})

ins_left({
	"diff",
	symbols = { added = " ", modified = "󰝤 ", removed = " " },
	diff_color = {
		added = { fg = colors.pine },
		modified = { fg = colors.gold },
		removed = { fg = colors.love },
	},
	cond = conditions.hide_in_width,
})

ins_left({
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = { error = " ", warn = " ", info = " " },
	diagnostics_color = {
		color_error = { fg = colors.love },
		color_warn = { fg = colors.gold },
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
	color = { fg = colors.foam, gui = "bold" },
})

ins_right({
	"o:encoding",
	cond = conditions.hide_in_width,
	color = { fg = colors.pine, gui = "bold" },
})

ins_right({ "location" })

ins_right({
	function()
		return "▊"
	end,
	color = { fg = colors.foam },
	padding = { left = 1 },
})

return options
