call plug#begin('~/.config/nvim/plugged')

" General plugins
Plug 'altercation/vim-colors-solarized'

Plug 'ctrlpvim/ctrlp.vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'

Plug 'idris-hackers/idris-vim'

" Scala plugins
Plug 'derekwyatt/vim-scala'

call plug#end()

" Leader key
let mapleader = ","

set cpoptions+=$

" airline
set laststatus=2
let g:airline_left_sep=""
let g:airline_left_alt_sep="|"
let g:airline_right_sep=""
let g:airline_right_alt_sep="|"

" arrow keys disable
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

" brace completion
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

" CtrlP
let g:ctrlp_by_filename=1
let g:ctrlp_custom_ignore={"dir": "target"}
let g:ctrlp_map="<leader>e"
let g:ctrlp_root_markers=['build.sbt']
let g:ctrlp_use_caching=0
nnoremap <leader>v :CtrlP<Space>

" deoplete
let g:deoplete#enable_at_startup=1
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

" horizontal split splits below
set splitbelow

" indentation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

" line numbers
set number
set relativenumber

" mappings
" switch buffer
nnoremap <leader>w <C-w>

inoremap <esc> <nop>
inoremap jk <esc>
vnoremap <esc> <nop>
vnoremap jk <esc>

" mouse
set mouse-=a

" NERDTree
" Open NERDTree in the directory of the current file (or /home if no file is open)
function! NERDTreeToggleFind()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
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

" panes
nnoremap <leader>d :vsp<cr>
set splitright
nnoremap <leader>s :sp<cr>
set splitbelow

" quickfix
let sarsivim = 'sarsi-nvim'
if (executable(sarsivim) && has("nvim"))
  call rpcstart(sarsivim)
endif
nnoremap <leader>l :cfirst<cr>
nnoremap <leader>f :cnext<cr>
nnoremap <leader>g :cprevious<cr>
" set errorformat=%E\ %#[error]\ %#%f:%l:\ %m,%-Z\ %#[error]\ %p^,%-C\ %#[error]\ %m
" set errorformat+=,%-G%.%#
" noremap <silent> <Leader>l :cf /tmp/sbt.quickfix<CR>
" noremap <silent> <Leader>f :cn<CR>
" noremap <silent> <leader>g :cp<CR>
" noremap <silent> <Leader>q  :ccl<CR>

" show title
set title

" syntax highlighting
set t_Co=256
colorscheme solarized
syntax on
set background=dark

" tabular
vnoremap a= :Tabularize /=><CR>
vnoremap a, :Tabularize /<-<CR>

" utf-8 ftw
set encoding=utf-8

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
augroup extra_whitespace
  autocmd!
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" wrap textlines
set colorcolumn=121
set textwidth=120

" NERDTree separator
set fillchars=vert:\|
highlight VertSplit cterm=NONE ctermfg=black ctermbg=NONE
