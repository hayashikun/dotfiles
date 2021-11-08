call plug#begin('~/.vim/plugged')

Plug 'google/vim-searchindex'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'

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

colorscheme desert
highlight LineNr ctermfg=darkyellow

