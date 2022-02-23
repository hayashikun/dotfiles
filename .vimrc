set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'kana/vim-smartinput'
Plug 'airblade/vim-gitgutter'
Plug 'cocopon/iceberg.vim'

Plug 'prabirshrestha/vim-lsp'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'


call plug#end()

set clipboard=unnamed,unnamedplus
set completeopt=menuone
set noswapfile
set ruler
set tabstop=4
set autoindent
set smartindent
set expandtab
set smarttab
set shiftwidth=4
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P
set title
set wildmenu
set showcmd
set smartcase
set hlsearch
set background=dark
set incsearch
set hidden
set list
set listchars=tab:>\ ,extends:<
set number
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set mouse=a
set fileformat=unix

runtime! config/*.vim

colorscheme desert
highlight LineNr ctermfg=darkyellow

let mapleader = "\<Space>"


" termdebug
packadd termdebug
let g:termdebug_wide = 160


" Fern
let g:fern#default_hidden=1
nnoremap <silent> <Leader>f :<C-u>Fern .<CR>

