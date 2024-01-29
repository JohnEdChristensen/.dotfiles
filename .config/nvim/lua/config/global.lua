-- see keymaps for key config
--JEC
vim.opt.cursorline = true
vim.g.python3_host_prog=vim.fn.expand("~/.virtualenvs/neovim/bin/python3")


vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--/JEC
--
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
end
-- shorten message to prevent pop-ups (enter to continue)
vim.opt.shortmess:append("Aa")

-- default aurto
-- proper colors
vim.opt.termguicolors = true

-- more opinionated
vim.opt.number = true -- show linenumbers
vim.opt.mouse = "a" -- enable mouse
vim.opt.mousefocus = true
vim.opt.clipboard:append("unnamedplus") -- use system clipboard

vim.opt.timeoutlen = 400 -- until which-key pops up
vim.opt.updatetime = 250 -- for autocommands and hovers


-- use spaces as tabs
local tabsize = 2
vim.opt.expandtab = true
vim.opt.shiftwidth = tabsize
vim.opt.tabstop = tabsize

-- space as leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- smarter search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- indent
vim.opt.smartindent = true
vim.opt.breakindent = true

-- consistent number column
vim.opt.signcolumn = "yes:1"

-- how to show autocomplete menu
vim.opt.completeopt = "menuone,noinsert"

-- add folds with treesitter grammar
vim.opt.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- but open all by default
vim.opt.foldlevel = 99

-- global statusline
vim.opt.laststatus = 3

vim.cmd([[
let g:currentmode={
       \ 'n'  : '%#String# NORMAL ',
       \ 'v'  : '%#Search# VISUAL ',
       \ "\<C-V>" : '%#Title# V·Block ',
       \ 'V'  : '%#IncSearch# V·Line ',
       \ 'Rv' : '%#String# V·Replace ',
       \ 'i'  : '%#ModeMsg# INSERT ',
       \ 'R'  : '%#Substitute# R ',
       \ 'c'  : '%#CurSearch# Command ',
       \ 't'  : '%#ModeMsg# TERM ',
       \}
]])
vim.opt.statusline = "%{%g:currentmode[mode()]%} %* %t | %y | %* %= c:%c l:%l/%L %p%% 🦦 "

-- split right and below by default
vim.opt.splitright = true
vim.opt.splitbelow = true

--tabline
vim.opt.showtabline = 1

--windowline
vim.opt.winbar = "%f"

--don't continue comments automagically
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- hide cmdline when not used
--vim.opt.cmdheight = 0

-- scroll before end of window
vim.opt.scrolloff = 5

-- (don't == 0) replace certain elements with prettier ones
vim.opt.conceallevel = 0
