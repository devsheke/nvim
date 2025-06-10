vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.shortmess.F = true
opt.shortmess.W = true
opt.shortmess.c = true
opt.shortmess.I = true

opt.nu = true
opt.relativenumber = true
opt.termguicolors = true

opt.hlsearch = false
opt.incsearch = true
opt.scrolloff = 4
opt.signcolumn = "yes"
opt.isfname:append("@-@")
opt.guicursor = ""

opt.whichwrap:append("<>[]hl")

local o = vim.o

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