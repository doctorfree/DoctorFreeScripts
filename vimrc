set nocompatible
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
if has('mouse')
  set mouse=a
endif
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
if &t_Co > 255
  " colorscheme zenburn
  " let g:zenburn_force_dark_Background=1
  colorscheme calmar256-dark
  " colorscheme maroloccio
endif
set guifont=Inconsolata:h18
