local map = vim.keymap.set

map("n", "<leader>e", vim.cmd.Ex, { desc = "Bring up netrw" })
map("n", "<leader>fm", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format current buffer" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })

map("n", "J", "mzJ`z", { desc = "Fold lines upwards" })
map("n", "<C-u>", "<C-u>zz", { desc = "Keep cursor in the middle the screen while moving up" })
map("n", "<C-d>", "<C-d>zz", { desc = "Keep cursor in the middle the screen while moving down" })
map("n", "n", "nzzzv", { desc = "Keep cursor in the middle the screen while moving down markers" })
map("n", "N", "Nzzzv", { desc = "Keep cursor in the middle the screen while moving up markers" })

map("x", "<leader>p", [["_dP]], { desc = "Paste and send to void register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete and send to void register" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus pane on the left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus pane on the right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus pane below" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus pane above" })

map("i", "<C-a>", "<Left>", { desc = "Move cursor left in insert mode" })
map("i", "<C-d>", "<Right>", { desc = "Move cursor right in insert mode" })
map("i", "<C-s>", "<Down>", { desc = "Move cursor down in insert mode" })
map("i", "<C-w>", "<Up>", { desc = "Move cursor up in insert mode" })

map(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Fuzzy search for pattern in current buffer" }
)
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- trouble bindings
map(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle<cr>",
	{ desc = "Toggle Trouble diagnostics for current workspace" }
)

map(
	"n",
	"<leader>xf",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Toggle Trouble diagnostics for current buffer" }
)

map("n", "<leader>xq", "<cmd>Trouble qflist toggle", { desc = "Toggle Trouble quickfix list" })

map("n", "<leader>xl", function()
	require("trouble").toggle("loclist")
end, { desc = "Toggle Trouble loclist" })

map(
	"n",
	"gR",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "Toggle Trouble lsp references" }
)

-- Comment bindings
local api = require("Comment.api")
map(
	"n",
	"<leader>\\",
	api.toggle.linewise.current,
	{ desc = "Toggle comment on current line (linewise)" }
)

map(
	"n",
	"<C-\\>",
	api.toggle.blockwise.current,
	{ desc = "Toggle comment on current line (blockwise)" }
)

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

vim.keymap.set(
	"n",
	"<leader>c",
	api.call("toggle.linewise", "g@"),
	{ expr = true, desc = "Toggle comments (linewise) with dot-repeat support" }
)

vim.keymap.set(
	"n",
	"<leader>cc",
	api.call("toggle.blockwise", "g@"),
	{ expr = true, desc = "Toggle comments (blockwise) with dot-repeat support" }
)

map("x", "<leader>c", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.toggle.linewise(vim.fn.visualmode())
end, { desc = "Toggle comments (linewise) with dot-repeat support" })

map("x", "<leader>cc", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	api.toggle.blockwise(vim.fn.visualmode())
end, { desc = "Toggle comments (blockwise) with dot-repeat support" })
