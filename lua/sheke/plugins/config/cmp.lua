local cmp = require("cmp")

local M = {}

M.enabled = function()
	-- disable completion in comments
	local context = require("cmp.config.context")
	-- keep command mode completion enabled when cursor is in a comment
	if vim.api.nvim_get_mode().mode == "c" then
		return true
	else
		return not context.in_treesitter_capture("comment")
			and not context.in_syntax_group("Comment")
	end
end

M.snippet = {
	expand = function(args)
		require("luasnip").lsp_expand(args.body)
	end,
}

M.window = {
	completion = {
		scrollbar = false,
		side_padding = 1,
		border = "rounded",
		winhighlight = "Normal:Normal,FloatBorder:None,CursorLine:Visual,Search:None",
	},
	documentation = {
		border = "rounded",
		winhighlight = "Normal:Normal,FloatBorder:None",
	},
}

M.formatting = {
	fields = { "abbr", "kind", "menu" },
	format = require("lspkind").cmp_format({
		mode = "symbol_text",
		maxwidth = 50,
		ellipsis_char = "...",
		show_labelDetails = true,
	}),
}

M.mapping = cmp.mapping.preset.insert({
	["<C-p>"] = cmp.mapping.select_prev_item(),
	["<C-n>"] = cmp.mapping.select_next_item(),
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),

	["<CR>"] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Insert,
		select = true,
	}),

	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif require("luasnip").expand_or_jumpable() then
			vim.fn.feedkeys(
				vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
				""
			)
		else
			fallback()
		end
	end, { "i", "s" }),

	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif require("luasnip").jumpable(-1) then
			vim.fn.feedkeys(
				vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
				""
			)
		else
			fallback()
		end
	end, { "i", "s" }),
})

M.sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "nvim_lua" },
	{ name = "luasnip" },
}, {
	{ name = "path" },
	{ name = "buffer" },
})

return M
