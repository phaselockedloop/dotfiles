set nocompatible
set hlsearch
colorscheme koehler
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
map <F2> <Esc>:1,$!xmllint --format -<CR>
map <F3> <Esc>:e .<CR>
nnoremap <F5> :buffers<CR>:buffer<Space> 
set laststatus=2
noremap <silent> <F9> :silent !explorer.exe %:p:h<CR>
noremap <silent> <F10> :bd<CR>
noremap <silent> <F12> :bn<CR>
noremap <silent> <F11> :bp<CR>
set autowrite
filetype on
noremap ] <C-W><C-W>
autocmd BufWinEnter * let @/ = ""
au BufNewFile,BufRead *.gdml set filetype=gdml
au BufNewFile,BufRead *.json set filetype=json
set encoding=utf-8
