set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.vim/dein'))
call dein#add('Shougo/dein.vim')
call dein#add('bling/vim-airline')
call dein#add('nelstrom/vim-visual-star-search')
call dein#add('rust-lang/rust.vim')
call dein#add('fatih/vim-go')
call dein#add('elixir-lang/vim-elixir')
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#end()

set encoding=utf-8

syntax on

colorscheme torte

" Emphasize the current line
set cursorline

" Set search configures
set hlsearch
set ignorecase
set smartcase
set incsearch

" Extend cygwin terminal color
set t_Co=256

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

" タブ、空白の可視化
set list
set listchars=tab:>>,trail:<,nbsp:!

" 全角スペースをハイライト表示
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

" Use git grep
set grepprg=git\ grep\ -nIH
cabbrev grep silent grep!
autocmd QuickfixCmdPost *grep* cwindow
autocmd QuickFixCmdPost *grep* redraw!
