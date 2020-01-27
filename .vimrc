set number
syntax on
colorscheme desert
set tabstop=4
set expandtab
set cursorline
set showmatch
set smartcase
set mouse=a
set wrap
set ttyfast
set smartcase

" Text format
set formatoptions=tcqrn1
set tabstop=2
set expandtab
set noshiftround
set matchpairs+=<:>

" Display options
" set showcmd

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
