local map = vim.keymap.set

map("n", "<leader>e", vim.cmd.Ex, { desc = "Bring up netrw" })
map("n", "<leader>fm", function()
  require("conform").format({ lsp_fallback = true })
end, { desc = "Format current buffer" })

map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down" })

map("n", "J", "mzJ`z", { desc = "" })
map("n", "<C-u>", "<C-u>zz", { desc = "" })
map("n", "<C-d>", "<C-d>zz", { desc = "" })
map("n", "n", "nzzzv", { desc = "" })
map("n", "N", "Nzzzv", { desc = "" })

map("x", "<leader>p", [["_dP]], { desc = "Paste and send to void register" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete and send to void register" })

map("n", "<C-h>", "<C-w>h", { desc = "" })
map("n", "<C-l>", "<C-w>l", { desc = "" })
map("n", "<C-j>", "<C-w>j", { desc = "" })
map("n", "<C-k>", "<C-w>k", { desc = "" })

map("i", "<C-a>", "<Left>", { desc = "" })
map("i", "<C-d>", "<Right>", { desc = "" })
map("i", "<C-s>", "<Down>", { desc = "" })
map("i", "<C-w>", "<Up>", { desc = "" })

map(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Fuzzy search for pattern in current buffer" }
)
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "Make file executable", silent = true })

-- telescope bindings
local telescope = require("telescope.builtin")
map("n", "<leader>ff", telescope.find_files, { desc = "List files in the cwd" })
map("n", "<leader>fw", telescope.live_grep, { desc = "Search for a string in the cwd with live results" })
map("n", "<leader>fb", telescope.buffers, { desc = "Lists open buffers" })
map("n", "<leader>fh", telescope.help_tags, { desc = "Lists available help tags" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope Find all files" }
)

-- telescope bindings for lsp
map("n", "<leader>fr", telescope.lsp_references, { desc = "Lists LSP references" })
map("n", "<leader>fd", telescope.diagnostics, { desc = "Lists LSP diagnostics" })
map("n", "<leader>fs", telescope.lsp_document_symbols, { desc = "Lists LSP symbols in current buffer" })

-- telescope bindings for git
map("n", "<leader>gs", telescope.git_status, { desc = "Display git status" })
map("n", "<leader>gst", telescope.git_stash, { desc = "List stash items" })

-- trouble bindings
map("n", "<leader>xx", function()
  require("trouble").toggle()
end, { desc = "Toggle Trouble" })

map("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end, { desc = "Toggle Trouble workspace diagnostics" })

map("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end, { desc = "Toggle Trouble diagnostics" })

map("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end, { desc = "Toggle Trouble quickfix" })

map("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end, { desc = "Toggle Trouble loclist" })

map("n", "gR", function()
  require("trouble").toggle("lsp_references")
end, { desc = "Toggle Trouble quickfix" })

-- Comment bindings
local api = require("Comment.api")

-- toggle current line (linewise)
map('n', '<leader>\\', api.toggle.linewise.current)

-- toggle current line (blockwise)
map('n', '<C-\\>', api.toggle.blockwise.current)

local esc = vim.api.nvim_replace_termcodes(
  '<ESC>', true, false, true)

-- toggle lines (linewise) with dot-repeat support
vim.keymap.set(
  'n', '<leader>c', api.call('toggle.linewise', 'g@'),
  { expr = true }
)

-- toggle lines (blockwise) with dot-repeat support
vim.keymap.set(
  'n', '<leader>cc', api.call('toggle.blockwise', 'g@'),
  { expr = true }
)

-- toggle selection (linewise)
map('x', '<leader>c', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.linewise(vim.fn.visualmode())
end)

-- toggle selection (blockwise)
map('x', '<leader>cc', function()
  vim.api.nvim_feedkeys(esc, 'nx', false)
  api.toggle.blockwise(vim.fn.visualmode())
end)
