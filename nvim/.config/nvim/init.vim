" vim:foldmethod=marker:foldlevel=0

" plugins {{{
call plug#begin('~/.config/nvim/plugged')

" General plugins
Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/fzf', { 'dir': '~/.fzf-vim', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'

" Scala plugins
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }

call plug#end()
" }}}

" Neovim
if has("nvim")
  set inccommand=split
endif

" general settings {{{
let mapleader = ","

set cpoptions+=$
set encoding=utf-8
set incsearch
set mouse-=a
set nocompatible
set nohlsearch
set number
set relativenumber
set title

nnoremap <leader>w <C-w>

" panes
nnoremap <leader>d :vsp<cr>
set splitright
nnoremap <leader>s :sp<cr>
set splitbelow

" }}}

" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"

" arrow keys disable {{{
nnoremap <up>     <nop>
nnoremap <down>   <nop>
nnoremap <left>   <nop>
nnoremap <right>  <nop>

inoremap <up>     <nop>
inoremap <down>   <nop>
inoremap <left>   <nop>
inoremap <right>  <nop>

vnoremap <up>     <nop>
vnoremap <down>   <nop>
vnoremap <left>   <nop>
vnoremap <right>  <nop>
" }}}

" brace completion {{{
set showmatch
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap {}     {}

inoremap (      ()<Left>
inoremap (<CR>  (<CR>)<Esc>O
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap ()     ()

inoremap [      []<Left>
inoremap [<CR>  [<CR>]<Esc>O
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap []     []
" }}}

" deoplete
let g:deoplete#enable_at_startup=1
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

" formatting {{{
" indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" tabular
vnoremap a= :Tabularize /=><CR>
vnoremap a, :Tabularize /<-<CR>

" wrap textlines
set colorcolumn=121
set textwidth=120
" }}}

" NERDTree {{{
" Open NERDTree in the directory of the current file (or /home if no file is open)
function! NERDTreeToggleFind()
  if exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    execute ":NERDTreeClose"
  else
    execute ":NERDTreeFind"
  endif
endfunction

augroup nerdtree_startup
  autocmd!
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
nnoremap <leader>c :call NERDTreeToggleFind()<cr>
" }}}

" tooling {{{
" FZF
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages'
else
  let $FZF_DEFAULT_COMMAND = 'find * -type f -not -path "*/target/*"'
endif

nnoremap <leader>v :Files<cr>

" quickfix
let sarsivim = 'sarsi-nvim'
if executable(sarsivim) && has("nvim")
  call rpcstart(sarsivim)
endif
nnoremap <leader>l :cfirst<cr>
nnoremap <leader>f :cnext<cr>
nnoremap <leader>g :cprevious<cr>
" }}}

" syntax {{{
" syntax highlighting
set t_Co=256

" If this is not an SSH session
if strlen($SSH_CLIENT) == 0
  colorscheme solarized
endif

syntax on
set background=dark

" highlight dangling whitespace
highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
augroup extra_whitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END
" }}}

" NERDTree separator
set fillchars=vert:\|
highlight VertSplit cterm=NONE ctermfg=black ctermbg=NONE
