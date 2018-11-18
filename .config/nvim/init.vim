" Load Plugins {{{

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible' " Default settings
Plug 'Shougo/neosnippet.vim' " Snippet engine
Plug 'Shougo/neosnippet-snippets' " Snippets
Plug 'honza/vim-snippets' " More Snippets
Plug 'Shougo/neco-syntax' " Completion for many langauges
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Asynchronus completion
Plug 'zchee/deoplete-jedi' " Python completion
Plug 'zchee/deoplete-clang' " C++ completion
Plug 'sebastianmarkow/deoplete-rust' " Rust completion
Plug 'artur-shaik/vim-javacomplete2' " Java completion
Plug 'rust-lang/rust.vim' " Rust
Plug 'calviken/vim-gdscript3'
Plug 'w0rp/ale' " Lint engine
Plug 'morhetz/gruvbox' " Colorscheme
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

" }}}
" Vim Settings {{{

filetype indent on

set undofile " Save undo history

set expandtab " Insert spaces on tab
set tabstop=2 " Number of spaces for tab
set shiftwidth=2
set softtabstop=2

set ignorecase
set smartcase

set number " Show line numbers
set relativenumber " Make all line numbers except current

set foldmethod=marker

set nohlsearch

set autochdir

set completeopt-=preview " Don't open a window for completion previews
set completeopt+=noinsert
set splitright

" }}}
" Colorscheme {{{

set termguicolors " Truecolor support

set background=dark " Dark colors
colorscheme gruvbox " Colorscheme

" }}}
" Plugin settings {{{

let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang/'
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 50
inoremap <expr> <C-n>  deoplete#mappings#manual_complete()

let g:deoplete#enable_at_startup = 1

let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:ale_linters = {"cpp" : ['clang', 'clangtidy', 'cppcheck', 'cpplint'], "tex" : []}
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_clangtidy_options = '-std=c++17'

let g:vim_markdown_folding_disabled = 1

" }}}
" Compile and execute code {{{

autocmd filetype python nnoremap  <Space>   :wa <bar> vsplit +terminal\ python3\ %:p<CR>
autocmd filetype c nnoremap       <Space>   :wa <bar> vsplit +terminal\ clang\ %:p\ -o\ %:p:r.out\ &&\ %:p:r.out<CR>
autocmd filetype d nnoremap       <Space>   :wa <bar> vsplit +terminal\ rdmd\ %:p<CR>
autocmd filetype rust nnoremap    <Space>   :wa <bar> vsplit +terminal\ cargo\ run\ %:p<CR>
autocmd filetype cpp nnoremap     <Space>   :wa <bar> vsplit +terminal\ clang++\ -Wall\ -std=c++17\ %:p\ -o\ %:p:r.out\ &&\ %:p:r.out<CR>
autocmd filetype cpp nnoremap     <C-Space> :wa <bar> vsplit +terminal\ make\ &&\ %:p:r.out<CR>
autocmd filetype java nnoremap    <Space>   :wa <bar> vsplit +terminal\ javac\ %:p\ &&\ java\ -cp\ %:h\ %:t:r<CR>
autocmd filetype haskell nnoremap <Space>   :wa <bar> vsplit +terminal\ ghc\ %:p\ &&\ %:p:r<CR>
autocmd filetype js nnoremap      <Space>   :wa <bar> silent !qutebrowser :reload<CR>
autocmd filetype html nnoremap    <Space>   :wa <bar> silent !qutebrowser :reload<CR>
autocmd filetype css nnoremap     <Space>   :wa <bar> silent !qutebrowser :reload<CR>
autocmd filetype gdscript3 nnoremap      <Space>   :wa <bar> !godot<CR>
autocmd filetype tex nnoremap     <Space>   :wa <bar> silent if empty(glob("main.tex")) <bar> call jobstart('latexmk ' . expand('%:p') . ' -pdf -synctex=1 -shell-escape -outdir=out') <bar> else <bar> call jobstart('latexmk ' . expand('%:p:h') . '/main.tex -pdf -synctex=1 -shell-escape -outdir=out') <bar> endif<CR><CR>
autocmd filetype tex nnoremap     <C-Space>   :wa <bar> silent if empty(glob("main.tex")) <bar> call jobstart('okular ' . expand('%:p:h').'/out/'.expand('%:t:r').'.pdf') <bar> else <bar> call jobstart('okular ' . expand('%:p:h').'/out/main.pdf') <bar> endif<CR><CR>
"autocmd filetype tex nnoremap     <C-Space> :wa <bar> call jobstart('okular '.expand('%:p:h').'/out/'.expand('%:t:r').'.pdf')<CR>

" }}}
" Mappings {{{

inoremap jk <Esc>
inoremap {<CR>  {<CR>}<Esc>O
nnoremap <Leader>s [s1z=
tnoremap <Esc> <C-\><C-n>

imap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup()."\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

function! BgToggle()
    if (&background == "light")
        set background=dark
    else
        set background=light
    endif
endfunction
nnoremap <silent> <TAB> :call BgToggle()<CR>

" }}}
" Abbreviations {{{

autocmd filetype python abbr fori for i in range(

" }}}
