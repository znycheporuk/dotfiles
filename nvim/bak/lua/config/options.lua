-- Core Neovim options configuration

local opt = vim.opt

-- Appearance
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.laststatus = 3 -- global statusline

-- Font configuration (same as ghostty)
opt.guifont = "ComicShannsMono Nerd Font:h20"

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Behavior
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = "indent,eol,start"
opt.splitright = true
opt.splitbelow = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Completion
opt.completeopt = "menuone,noselect"
opt.pumheight = 15

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

-- File encoding
opt.fileencoding = "utf-8"

-- Mouse
opt.mouse = "a"

-- Performance
opt.updatetime = 300
opt.timeoutlen = 500

-- Window management
-- Removed winminwidth and winminheight to avoid conflicts
