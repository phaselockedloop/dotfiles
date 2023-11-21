call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter', { 'branch': 'main' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'pseewald/vim-anyfold'
Plug 'arecarn/vim-fold-cycle'
call plug#end()
syntax on
set novisualbell
set noerrorbells
set nocompatible
set t_Co=256
set hlsearch
colorscheme koehler2
set ignorecase
set nobackup
set nowritebackup
set noswapfile
set tabstop=4
set expandtab
set cindent
set autoindent
set smartindent
set shiftwidth=4
set number
set autochdir
set laststatus=2
set mouse=
noremap <silent> <F10> :bd<CR>
noremap <silent> <F12> :bn<CR>
noremap <silent> <F11> :bp<CR>
set autowrite
filetype on
autocmd BufWinEnter * let @/ = ""
au BufNewFile,BufRead *.json set filetype=json
hi CursorLine term=NONE cterm=NONE ctermbg=239
set encoding=utf-8
set cursorline
map <C-t> :NERDTreeToggle<CR>
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" set foldmethod=indent
" set foldexpr=MyFoldLevel(v:lnum)

function! MyFoldLevel(lnum)
    let line = getline(a:lnum)
    if line =~ '^\\s\\+'  " matches any line that starts with one or more spaces
        return '>1'
    endif
    return '0'
endfunction

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <F5> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>

set ttimeout
set ttimeoutlen=100
set timeoutlen=3000
set spelllang=en_ca
set guicursor-=a:blinkon0
