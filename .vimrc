set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'google/vim-searchindex'

Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-hijack.vim'

Plug 'kana/vim-smartinput'

Plug 'airblade/vim-gitgutter'
Plug 'cocopon/iceberg.vim'

Plug 'prabirshrestha/vim-lsp'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern-git-status.vim'

Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'khaveesh/vim-fish-syntax'


call plug#end()

set clipboard=unnamed,unnamedplus
set completeopt=menuone
set nocompatible
set noswapfile
set ruler
set nowrap
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
set modelines=2

runtime! config/*.vim

highlight LineNr ctermfg=darkyellow

if has('vim_starting')
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif

let mapleader = "\<Space>"

for [c1, c2] in [['(', ')'], ['{', '}'], ['[', ']'], ['<', '>'], ['"', '"'], ["'", "'"], ["`", "`"]]
    call smartinput#define_rule({'at': c1.c2.'\%#', 'char': '<BS>', 'input': '<BS>'})
endfor

call smartinput#define_rule({
\   'at': '\s\+\%#',
\   'char': '<CR>',
\   'input': "<C-o>:call setline('.', substitute(getline('.'), '\\s\\+$', '', ''))<CR><CR>",
\   })


" termdebug
packadd! termdebug
let g:termdebug_wide = 160


" Fern
let g:fern#default_hidden=1
nnoremap <silent> <Leader>f :<C-u>Fern . -reveal=%<CR>

" fzf
nnoremap <silent> <leader>/ :Rg<CR>
nnoremap <silent> <leader>g :Files<CR>

