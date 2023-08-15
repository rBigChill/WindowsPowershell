set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4
set hlsearch
set incsearch
set smartcase
set linebreak
syntax enable
set laststatus=2
set ruler
set number
set noerrorbells
set title
set background=dark
set history=1000
set backspace=indent,eol,start
set vb t_vb=
set ff=unix
set noshowmode
set encoding=utf-8

call plug#begin('~/.vim/plugged')

    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'mattn/emmet-vim'
    Plug 'vim-syntastic/syntastic'
    Plug 'valloric/youcompleteme'

call plug#end()

:PlugUpdate
ZZ
:PlugUpgrade
ZZ
