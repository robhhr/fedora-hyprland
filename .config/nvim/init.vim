echo ">^.^<"

let mapleader='\<Space>'

set number
set numberwidth=5

" remaps
map ss viw

" package manager
call plug#begin("~/.vim/plugged")

" colorschemes & aesthetics
Plug 'dracula/vim'

" file manager
Plug 'scrooloose/nerdtree'

" ui
Plug 'ryanoasis/vim-devicons'

call plug#end()