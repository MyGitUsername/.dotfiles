" Automatic installation vim-plug if it isn't installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot' " Collection of language packs
Plug 'altercation/vim-colors-solarized'
" Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Vim Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let mapleader = ','
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0

set background=dark
syntax enable
colorscheme solarized

" Spaces and Tabs
set shiftwidth=2
set softtabstop=2     " the number of spaces <TAB> character counts for when editing a file
set expandtab        " tabs are spaces (e.g., <TAB> is a shortcut for add four spaces)

" Turn hybrid line numbers on
set number relativenumber

" filetype indent on      " turns on language detection and allows loading of language specific indentation
" (e.g., loads python indentation that lives in ~/.vim/indent/python.vim)
filetype plugin on      " loads typescript config that lives in ~/.vim/after/ftplugin/ts.vim
" set wildmenu         " provides graphical menu for when autocompletion is triggered
set lazyredraw        " redraw the screen only when required
set showmatch         " highlights matching parenthesis-like character when cursor is hovered over one

set nowrap
" jj key is <Esc> setting
inoremap jj <Esc>
inoremap ;; <Esc>

" Searching
set incsearch " search as characters are entered
set hlsearch
nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight with <SPACE>

set scrolloff=8
