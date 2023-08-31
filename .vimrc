filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline
set cursorcolumn
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set noshowmode
set showmatch
set hlsearch
set history=1000
set wildmenu
set wildmenu=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

set nocompatible
set autoindent
set shiftround
set smarttab
set linebreak
set ruler
set noerrorbells
set title
set background=dark
set backspace=indent,eol,start
set vb t_vb=
set encoding=utf-8

call plug#begin('~/.vim/plugged')

    Plug 'itchyny/lightline.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    Plug 'mattn/emmet-vim'
    Plug 'vim-syntastic/syntastic'
    Plug 'valloric/youcompleteme'

call plug#end()

PlugUpdate | PlugUpgrade | :q!

let mapleader = "\"
nnoremap <leader>\ :nohlsearch<CR>
nnoremap <F5> :w <CR>:!clear <CR>:!python3 % <CR>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>
nnoremap <c-right> <c-w><
nnoremap <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

inoremap jj <esc>
inoremap <space> :

