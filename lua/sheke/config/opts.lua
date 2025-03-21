local opt = vim.opt
local o = vim.o

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.shortmess.F = true
vim.opt.shortmess.W = true
vim.opt.shortmess.c = true
vim.opt.shortmess.I = true

opt.nu = true
opt.relativenumber = true
opt.termguicolors = true

opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.guicursor = ""

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

o.number = true
o.numberwidth = 2
o.ruler = false

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

opt.whichwrap:append("<>[]hl")
