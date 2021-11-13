set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'google/vim-searchindex'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'cocopon/iceberg.vim'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

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

inoremap <C-j>  <down>
inoremap <C-k>  <up>
inoremap <C-h>  <left>
inoremap <C-l>  <right>
inoremap {  {}<LEFT>
inoremap [  []<LEFT>
inoremap (  ()<LEFT>
inoremap "  ""<LEFT>
inoremap '  ''<LEFT>

colorscheme desert
highlight LineNr ctermfg=darkyellow

let g:lsp_diagnostics_echo_cursor = 1
autocmd BufWritePre <buffer> LspDocumentFormatSync

inoremap <expr><Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

