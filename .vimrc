set nocompatible
filetype off  " for NeoBundle

if has('vim_starting')
   set rtp+=$HOME/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
   NeoBundleFetch 'Shougo/neobundle.vim'
   " Plugins managed by NeoBundle
   NeoBundle 'bling/vim-airline'
   NeoBundle 'plasticboy/vim-markdown'
   NeoBundle 'kannokanno/previm'
   NeoBundle 'tyru/open-browser.vim'
   NeoBundle 'elixir-lang/vim-elixir'
   NeoBundle 'rust-lang/rust.vim'
   NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}
call neobundle#end()

filetype plugin indent on  " restore filetype

" relations of file extensions and file types
au BufRead,BufNewFile *.md set filetype=markdown

let g:vim_markdown_folding_disabled = 1

syntax on

colorscheme torte

" Emphasize the current line
set cursorline

" Set highlight on search
set hlsearch

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
set tabstop=3
set shiftwidth=3
set softtabstop=3
set smartindent

" Set status line for vim-airline
set laststatus=2

" タブ、空白、改行の可視化
set list
set listchars=tab:>>,trail:<

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
