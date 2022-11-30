call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'bronson/vim-visual-star-search'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'slim-template/vim-slim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

set belloff=all
set encoding=utf-8

syntax on

colorscheme elflord

set number
set foldmethod=syntax
set foldlevel=8

" Emphasize the current line
set cursorline

" Set search configures
set hlsearch
set ignorecase
set smartcase
set incsearch

" Enable backspace
set backspace=indent,eol,start

" Disable automatic carrier return
set tw=0

" Enable to move the upper and lower lines by typing the left key from BOL and the right key from EOL, respectively.
set whichwrap=b,s,h,l,[,],<,>

" Change the tab key
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smartindent

" Set status line for vim-airline
set laststatus=2

" Visualize tab and trailing spaces
set list
set listchars=tab:>>,trail:<,nbsp:!

" Highlight zenkaku space
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkRed gui=reverse guifg=DarkRed
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

if has('vim_starting')
  " 挿入モード時に非点滅の縦棒タイプのカーソル
  let &t_SI .= "\e[6 q"
  " ノーマルモード時に非点滅のブロックタイプのカーソル
  let &t_EI .= "\e[2 q"
  " 置換モード時に非点滅の下線タイプのカーソル
  let &t_SR .= "\e[4 q"
endif

" vim-lsp
let g:lsp_diagnostics_echo_cursor = 1
