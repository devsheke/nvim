local cmp = require("cmp")

local M = {}

M.snippet = {
	expand = function(args)
		require("luasnip").lsp_expand(args.body)
	end,
}

M.window = {
	completion = cmp.config.window.bordered(),
	documentation = cmp.config.window.bordered(),
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
