set nu
set smartindent
set cindent
set tabstop=2
set softtabstop=2
set expandtab
set shiftwidth=2
set cursorline
set scrolloff=3
set incsearch
colorscheme desert
set sidescroll=1
set sidescrolloff=10
set showcmd
set wildmenu
set wildmode=longest:full
set nocompatible
set fileencoding=utf8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf8
set magic
set ic
set hlsearch

" first search something, \z to fold anything else
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>                                  

