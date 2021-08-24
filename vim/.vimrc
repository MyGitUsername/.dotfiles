" Install plugin manager and plugins if plugin manager DNE
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot' " Collection of language packs
Plug 'dense-analysis/ale' " Lints code as you type
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"  Plug 'ervandew/supertab'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

call plug#end()

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

" Ale Lint settings
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'javascript': ['prettier'],
      \   'css': ['prettier'],
      \   'react': ['prettier'],
      \   'vue': ['prettier'],
      \}

let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'css': ['eslint'],
      \   'react': ['eslint'],
      \   'vue': ['eslint'],
      \}

let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_set_highlights = 0

" Fuzzy File Finder with F2
map <silent> <F2> :FZF<CR>
