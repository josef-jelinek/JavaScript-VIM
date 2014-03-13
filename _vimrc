set nocompatible
set showmatch
set expandtab
set tabstop=4
set shiftwidth=4
set smarttab
set shiftround
set autoindent
set scrolloff=4
set scrolljump=8
set showcmd
set cmdheight=3
set hlsearch
set incsearch
set ignorecase
set smartcase
set number
set ruler
set lisp
" set list
set cursorline
set backspace=indent,eol,start
set nojoinspaces
set noendofline
" set guifont=Anonymous_Pro:h12
set guifont=PragmataPro:h11
set encoding=utf-8
set fileencoding=utf-8
colorscheme mustang
syntax enable
au GUIEnter * simalt ~x
set noswapfile
" jslint
nmap <F4> :w<CR>:make<CR>:cw<CR>
filetype plugin on
filetype indent on
