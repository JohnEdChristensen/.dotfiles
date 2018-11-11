execute pathogen#infect()
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"Status bar
set laststatus=2
set statusline=%t       "tail of the filename
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype

set statusline+=%=      "left/right separator
set statusline+=%l/%L   "cursor line/total lines


let g:syntastic_cpp_check_header = 1
let g:syntastic_check_on_en = 1
let g:syntastic_check_on_wq = 0
filetype plugin indent on
"Typing jk exits insert mode 
inoremap jk <Esc>

set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


"inoremap <A-k> <C-o>k
"inoremap <A-l> <C-o>l
"Adds number lines to the side of the screen
set number
"Enabels mouse
set mouse=a
"Set scheme
set t_Co=256
set background=dark
colorscheme solarized8_dark_flat
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE
"Highlight characters past 80 columns
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

hi statusline ctermbg=NONE ctermfg=cyan cterm=NONE 
"Vim Todo
let g:VimTodoListsMoveItems = 0
