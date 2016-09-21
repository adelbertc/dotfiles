call plug#begin('~/.config/nvim/plugged')

" General plugins
Plug 'altercation/vim-colors-solarized'

Plug 'ctrlpvim/ctrlp.vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'

" Scala plugins
Plug 'derekwyatt/vim-scala'

call plug#end()

" Leader key
let mapleader = ","

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

" map <C-w>w (switch buffer focus) to something nicer
nnoremap <leader>w <C-w>w

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

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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

" show title
set title

" syntax highlighting
set t_Co=256
colorscheme solarized
syntax on
set background=dark

" utf-8 ftw
set encoding=utf-8

" whitespace
highlight ExtraWhitespace ctermbg=red guibg=red

match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" wrap textlines
set colorcolumn=121
set textwidth=120
