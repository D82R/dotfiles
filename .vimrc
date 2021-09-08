set nocompatible
set hidden
filetype off

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Download plug-ins to the ~/.vim/plugged/ directory
call vundle#begin('~/.vim/plugged')
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'morhetz/gruvbox'
Plugin 'jiangmiao/auto-pairs'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
Plugin 'preservim/nerdtree'
"Plugin 'ycm-core/YouCompleteMe'

call vundle#end()
filetype plugin indent on

set background=dark    " Setting dark mode
colorscheme badwolf    " Color theme
set termguicolors

set nu     " Enable line numbers
syntax on  " Enable syntax highlighting
" How many columns of whitespace a \t is worth
set tabstop=4

" How many columns of whitespace a "level of indentation" is worth
set shiftwidth=4

" Use spaces when tabbing
set expandtab
set incsearch  " Enable incremental search
set hlsearch   " Enable highlight search

set termwinsize=12x0   " Set terminal size
set splitbelow         " Always split below
"set mouse=a            " Enable mouse drag on window splits

let g:AutoPairsShortcutToggle = '<C-P>'   " Toggles autopair mode (CTRL + P)
let g:airline_theme='badwolf'
