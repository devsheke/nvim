local M = {}

M.opts = {
	bigfile = { enabled = true, notify = true },
	bufdelete = { enabled = true },
	git = { enabled = true },
	indent = {
		enabled = true,
		animate = { enabled = false },
	},
	input = { enabled = false },
	notifier = {
		enabled = true,
		filter = function(notif)
			return not string.find(notif.msg, "written")
		end,
	},
	lazygit = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
}

M.opts.dashboard = {
	enabled = true,
	preset = {
		header = [[
                     /$$                  /$$              
                    | $$                 |__/              
  /$$$$$$$  /$$$$$$$| $$$$$$$  /$$    /$$ /$$ /$$$$$$/$$$$ 
 /$$_____/ /$$_____/| $$__  $$|  $$  /$$/| $$| $$_  $$_  $$
|  $$$$$$ | $$      | $$  \ $$ \  $$/$$/ | $$| $$ \ $$ \ $$
 \____  $$| $$      | $$  | $$  \  $$$/  | $$| $$ | $$ | $$
 /$$$$$$$/|  $$$$$$$| $$  | $$   \  $/   | $$| $$ | $$ | $$
|_______/  \_______/|__/  |__/    \_/    |__/|__/ |__/ |__/]],
	},
	pane_gap = 20,
	sections = {
		{ section = "header", text = "hello" },
		{
			section = "terminal",
			cmd = "chafa ~/Pictures/cats.png --format symbols --symbols vhalf --size 60x20 --stretch; sleep .1",
			height = 20,
			padding = 1,
		},
		{ pane = 2, title = "Bookmarks", icon = "", padding = 1 },
		{
			pane = 2,
			section = "keys",
			gap = 1,
			padding = 1,
		},
		{ pane = 2, title = "Recents", icon = "", padding = { 1, 2 } },
		{
			pane = 2,
			section = "recent_files",
			gap = 1,
			padding = 2,
		},

		{ pane = 2, section = "startup", icon = "⚡⚡ " },
	},
}

local picker_layouts = {
	telescope = {
		reverse = true,
		layout = {
			box = "horizontal",
			backdrop = false,
			width = 0.8,
			height = 0.9,
			border = "none",
			{
				box = "vertical",
				{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
				{
					win = "input",
					height = 1,
					border = "rounded",
					title = "{title} {live} {flags}",
					title_pos = "center",
				},
			},
			{
				win = "preview",
				title = "{preview:Preview}",
				width = 0.50,
				border = "rounded",
				title_pos = "center",
			},
		},
	},

	vscode = {
		preview = false,
		layout = {
			backdrop = false,
			row = 10,
			width = 0.4,
			min_width = 80,
			height = 0.4,
			border = "rounded",
			box = "vertical",
			{
				win = "input",
				height = 1,
				border = "rounded",
				title = "{title} {live} {flags}",
				title_pos = "center",
			},
			{ win = "list", border = "hpad" },
			{ win = "preview", title = "{preview}", border = "rounded" },
		},
	},
}

M.opts.picker = {
	enabled = true,
	layout = {
		preset = "telescope", -- defaults to this layout unless overidden
	},
	layouts = picker_layouts,
	sources = {
		buffers = {
			layout = {
				preset = "vscode",
			},
		},
	},
}

M.keys = {
	{
		"<leader>lg",
		function()
			require("snacks").lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>gl",
		function()
			require("snacks").lazygit.log()
		end,
		desc = "Lazygit Logs",
	},
	-- Pickers
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fw",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>:",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>fn",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	{
		"<leader>fa",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fp",
		function()
			Snacks.picker.projects()
		end,
		desc = "Projects",
	},
	{
		"<leader>gs",
		function()
			Snacks.picker.git_status()
		end,
		desc = "Git Status",
	},
	{
		"<leader>gS",
		function()
			Snacks.picker.git_stash()
		end,
		desc = "Git Stash",
	},
	{
		"<leader>gD",
		function()
			Snacks.picker.git_diff()
		end,
		desc = "Git Diff (Hunks)",
	},
	{
		'<leader>s"',
		function()
			Snacks.picker.registers()
		end,
		desc = "Registers",
	},
	{
		"<leader>s/",
		function()
			Snacks.picker.search_history()
		end,
		desc = "Search History",
	},
	{
		"<leader>s:",
		function()
			Snacks.picker.commands()
		end,
		desc = "Commands",
	},
	{
		"<leader>sd",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>sD",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>sH",
		function()
			Snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>si",
		function()
			Snacks.picker.icons()
		end,
		desc = "Icons",
	},
	{
		"<leader>sk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>sm",
		function()
			Snacks.picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>sp",
		function()
			Snacks.picker.lazy()
		end,
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>su",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo History",
	},
	{
		"<leader>uC",
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
	{
		"gd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"gD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"gr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"gI",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"gy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>ss",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>sS",
		function()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
}

return M
