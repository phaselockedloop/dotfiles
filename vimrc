call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'cespare/vim-toml'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'airblade/vim-gitgutter', { 'branch': 'main' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons', { 'opt': 1 }
Plug 'wsdjeg/vim-fetch'
Plug 'arecarn/vim-fold-cycle'
call plug#end()

syntax on
set novisualbell
set noerrorbells
set nocompatible
set t_Co=256
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
set guicursor=n-v-c:block-blinkon500-blinkoff500,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr:hor20-blinkon500-blinkoff500,o:hor50
set ttyfast
set lazyredraw
set termguicolors

" Removed airline theme setting
" let g:airline_theme = 'minimalist'

" Configure lualine with a minimalist theme similar to your airline theme
lua << EOF
-- Function to detect mixed indentation
local function mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]

  -- Save current view state
  local save_cursor = vim.fn.getpos(".")
  local save_view = vim.fn.winsaveview()

  -- Search without moving cursor
  local space_indent = vim.fn.search(space_pat, 'nw')
  local tab_indent = vim.fn.search(tab_pat, 'nw')

  -- Restore view and cursor position
  vim.fn.winrestview(save_view)
  vim.fn.setpos(".", save_cursor)

  if space_indent > 0 and tab_indent > 0 then
    return string.format('Mixed Indent [L:%d,%d]', math.min(space_indent, tab_indent), math.max(space_indent, tab_indent))
  end
  return ''
end

-- Function to detect trailing whitespace with line numbers
local function trailing_whitespace()
  local pattern = [[\s\+$]]

  -- Save current view state
  local save_cursor = vim.fn.getpos(".")
  local save_view = vim.fn.winsaveview()

  local lines = {}
  local count = 0

  -- Use nohlsearch to avoid highlighting matches
  vim.cmd('keepjumps nohlsearch')
  vim.cmd('keepjumps normal! gg')

  -- Find lines with trailing whitespace using faster search
  local line_num = vim.fn.search(pattern, 'W')
  while line_num > 0 and count < 3 do
    table.insert(lines, line_num)
    count = count + 1
    line_num = vim.fn.search(pattern, 'W')
  end

  -- Restore view and cursor position
  vim.fn.winrestview(save_view)
  vim.fn.setpos(".", save_cursor)

  -- Format the output
  if #lines == 0 then
    return ''
  elseif #lines == 1 then
    return string.format('Trailing WS [L:%d]', lines[1])
  elseif #lines == 2 then
    return string.format('Trailing WS [L:%d,%d]', lines[1], lines[2])
  else
    return string.format('Trailing WS [L:%d,%d,+]', lines[1], lines[2])
  end
end

-- Simple cache for whitespace checks
local ws_cache = {
  last_check = 0,
  result = '',
  check_interval = 1000,  -- milliseconds
}

-- Function that combines both checks with colors
local function whitespace_check()
  -- Check cache freshness (avoid running on every statusline update)
  local current_time = vim.loop.now()
  if current_time - ws_cache.last_check < ws_cache.check_interval then
    return ws_cache.result
  end

  local mixed = mixed_indent()
  local trailing = trailing_whitespace()

  if mixed == '' and trailing == '' then
    ws_cache.result = ''
    ws_cache.last_check = current_time
    return ''
  end

  local result = mixed ~= '' and ('%#ErrorMsg#' .. mixed .. '%*') or ''

  if trailing ~= '' then
    if result ~= '' then
      result = result .. ' %#WarningMsg#' .. trailing .. '%*'
    else
      result = '%#WarningMsg#' .. trailing .. '%*'
    end
  end

  ws_cache.result = result
  ws_cache.last_check = current_time
  return result
end

require('lualine').setup {
  options = {
    theme = 'material',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {
      { whitespace_check },
      'encoding',
      'fileformat',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
}
EOF
