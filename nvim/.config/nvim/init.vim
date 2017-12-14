" vim:foldmethod=marker:foldlevel=0

" plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" General plugins
Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/fzf', { 'dir': '~/.fzf-vim', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'junegunn/goyo.vim'
Plug 'benekastah/neomake'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }

" Haskell plugins
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'owickstrom/neovim-ghci', { 'for': 'haskell' }

" Nix plugins
Plug 'LnL7/vim-nix', { 'for': 'nix' }

" Pandoc plugins
Plug 'vim-pandoc/vim-pandoc' ", { 'for': 'pandoc' }
Plug 'vim-pandoc/vim-pandoc-syntax' ", { 'for': 'pandoc' }

" Rust plugins
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

" Scala plugins
Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
Plug 'ensime/ensime-vim', { 'do': ':UpdateRemotePlugins' }

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
set guicursor=
set incsearch
set lazyredraw
set mouse-=a
set nocompatible
set nohlsearch
set number
set relativenumber
set title

" move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap <leader>w <c-w>

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
inoremap {      {}<left>
inoremap {<cr>  {<cr>}<esc>O
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<right>" : "}"
inoremap {}     {}

inoremap (      ()<left>
inoremap (<cr>  (<cr>)<esc>O
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<right>" : ")"
inoremap ()     ()

inoremap [      []<left>
inoremap [<cr>  [<cr>]<esc>O
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<right>" : "]"
inoremap []     []
" }}}

" deoplete
let g:deoplete#enable_at_startup=1
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : "\<c-i>"

" formatting {{{
" indentation
set tabstop=2     " visual spaces per tab
set softtabstop=2 " number of spaces inserted when you hit tab
set expandtab     " tabs are spaces
set shiftwidth=2  " spaces for >> and automatic indentation
set autoindent    " start newline at same indentation as previous

" tabular
vnoremap a= :Tabularize /=><cr>
vnoremap a, :Tabularize /<-<cr>

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
if executable("rg")
  let $FZF_DEFAULT_COMMAND = "rg --files --no-messages"
endif

nnoremap <leader>v :Files<cr>
nnoremap ; :Buffers<cr>

" quickfix
nnoremap <leader>l :cfirst<cr>
nnoremap <leader>f :cnext<cr>
nnoremap <leader>g :cprevious<cr>

augroup HaskellStuff
  autocmd!

  autocmd BufWritePost *.hs GhciReload

  autocmd FileType haskell nnoremap <silent> <leader>go :GhciOpen<cr>
  autocmd FileType haskell nnoremap <silent> <leader>gh :GhciHide<cr>
  autocmd FileType haskell nnoremap <silent> <leader>gl :GhciLoadCurrentModule<cr>
  autocmd FileType haskell nnoremap <silent> <leader>gf :GhciLoadCurrentFile<cr>

  let g:ghci_command = "cabal repl"
augroup END

augroup ScalaStuff
  autocmd!

  " .sbt is Scala highlighted
  autocmd BufRead,BufNewFile *.sbt set filetype=scala

  autocmd BufWritePost *.scala silent :EnTypeCheck
  autocmd FileType scala nnoremap <leader>gt :EnType<cr>
  autocmd FileType scala nnoremap <leader>gd :EnDeclarationSplit<cr>
  autocmd FileType scala nnoremap <leader>gf :EnDeclaration<cr>
augroup END

augroup RustStuff
  autocmd!

  autocmd FileType rust call neomake#configure#automake("w")

  let g:racer_cmd=$HOME . "/.cargo/bin/racer"
  autocmd FileType rust nmap <leader>rd <Plug>(rust-doc)
augroup END

augroup NeomakeSolarized
  autocmd!
  autocmd ColorScheme * hi SignColumn ctermbg=NONE
augroup END
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

" vim-pandoc
let g:pandoc#spell#enabled = 0
let g:pandoc#syntax#codeblocks#embeds#langs = [ "scala" ]

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
