echo "🌈✨"

function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#00FF00 guifg=#000000
endfunction

" == plugs ==

call plug#begin("~/.vim/plugged")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-snippets'
  Plug 'sts10/vim-pink-moon'
  Plug 'sainnhe/everforest'
  Plug 'nightsense/plumber'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'yaegassy/coc-intelephense', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc-tsserver'
  Plug 'neoclide/coc-css'
  Plug 'neoclide/coc-html'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ryanoasis/vim-devicons'
  Plug 'bagrat/vim-buffet'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
  Plug 'dense-analysis/ale'
call plug#end()

" == mappings ==

let mapleader=","

noremap <leader>w :w<CR>
noremap <leader>wq :wq<CR>
noremap <leader>q :q<CR>
noremap <leader>q! :q!<CR>

" Buffet
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)

" == plugs config ==

" colorscheme
if has('termiguicolors')
  set termguicolors
endif
 colorscheme pink-moon
set background=dark
" colorscheme plumber-dark
" let g:everforest_background = 'hard'
" colorscheme everforest
" nerdtree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeSortHiddenFirst = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1
nnoremap <Leader><Tab> :NERDTreeToggle<CR>
nnoremap <Leader>f :NERDTreeFocus<CR>
nnoremap <Leader>! :Bw!<CR>
" autocomplete
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']

if executable('intelephense')
  augroup LspPHPIntelephense
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'intelephense',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
        \ 'whitelist': ['php'],
        \ 'initialization_options': {'storagePath': '/tmp/intelephense'},
        \ 'workspace_config': {
        \   'intelephense': {
        \     'files': {
        \       'maxSize': 1000000,
        \       'associations': ['*.php', '*.phtml'],
        \       'exclude': [],
        \     },
        \     'completion': {
        \       'insertUseDeclaration': v:true,
        \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
        \       'triggerParameterHints': v:true,
        \       'maxItems': 100,
        \     },
        \     'format': {
        \       'enable': v:true
        \     },
        \   },
        \ }
        \})
  augroup END
endif

" use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" == config ==
packloadall

" general
set encoding=utf-8
set mouse=a
set cursorline
set hidden
set autoindent
set shell=zsh
set nobackup
set nowritebackup
set updatetime=300
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab autoindent
set splitright
set splitbelow
set ruler laststatus=2 showcmd showmode
set number
set nu
set title
set wrap breakindent
" close terminal
tnoremap <Esc> <C-\><C-n>
" open terminal on ctrl+n
function! OpenTerminal()
  split term://zsh
  resize 6
endfunction
nnoremap <Leader>` :call OpenTerminal()<CR>
