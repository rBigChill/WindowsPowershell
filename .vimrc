filetype on
filetype plugin on
filetype indent on
syntax on
set number
set cursorline
hi cursorline ctermbg=DarkGray
hi cursorlinenr ctermbg=DarkGray
hi cursorlinenr ctermfg=white
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
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set statusline=
set statusline+=\ %F\ %M\ %Y\ %R
set statusline+=%=
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

let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']
let mapleader = '\'
nnoremap <leader>\ :nohlsearch<CR>

nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F5> :w <CR>:!py % <CR>

nnoremap <C-w> <C-w>v
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-up> <C-w>+
nnoremap <C-down> <C-w>-
nnoremap <C-left> <C-w>>
nnoremap <C-right> <C-w><

nnoremap <space> :
nnoremap <space>w :w<CR>
nnoremap <space><space> ZZ

nnoremap o o<esc>
nnoremap O O<esc>

inoremap jj <esc>

PlugUpdate | PlugUpgrade | :q!
