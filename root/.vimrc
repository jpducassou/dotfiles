" ============================================================================
" General
" ============================================================================
" use vim defaults
set nocompatible

" allways show status line
set ls=2

" syntax highlighting
syntax on

" Enable omnifunc
filetype plugin indent on

" Set color palette
if &term == "xterm"
	set t_Co=256
endif

" Chuck Norris programing
set tabstop=2
set shiftwidth=2

" Show title in console title bar
set title

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" do not keep a backup file
set nobackup

" NoMatchParen
au vimEnter * NoMatchParen

" dont use Q for Ex mode
map Q :q

" Toggle line numbers on/off
map <F2> :set number!<CR>

" Toggle paren match
:hi MatchParen ctermbg=blue guibg=lightblue
let g:MatchParen = 0
function! ToggleParen()
    if g:MatchParen == 1
        let g:MatchParen = 0
        NoMatchParen
    else
        let g:MatchParen = 1
        DoMatchParen
    endif
endfunction
map <F3> :call ToggleParen()<CR>

" Toggle line numbers on/off
map <F4> :set list!<CR>

" ============================================================================
" Indentation
" ============================================================================
" Retain visual selection after < or >
vnoremap > >gv
vnoremap < <gv

" make tab in v mode ident code
vmap <tab>   >gv
vmap <s-tab> <gv

" make tab in normal mode ident code
nmap <tab>   I<tab><esc>
nmap <s-tab> ^i<bs><esc>

" ============================================================================
" Searching
" ============================================================================
"Usually I don't care about case when searching
set ignorecase

"Only ignore case when we type lower case when searching
set smartcase

" ============================================================================
" Wildmenu
" ============================================================================
"Show menu with possible tab completions
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc

"Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7

" ============================================================================
" Visual aid
" ============================================================================
" Create a highlight group for ws:
highlight ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" ============================================================================
" Set configuration file to apache style
" ============================================================================
autocmd BufNewFile,BufRead *.conf if empty(&syntax) | set filetype=apache | endif

" ============================================================================
" Programming
" ============================================================================
" show line numbers
autocmd FileType c,cpp,perl,php,java set number

autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldnestmax=1
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

map <F5> :make<CR>

" ============================================================================
" Markdown
" ============================================================================
autocmd FileType markdown set makeprg=markdown\ %\ >%<.html
autocmd FileType markdown set autowrite

" ============================================================================
" C
" ============================================================================
autocmd FileType c set makeprg=gcc\ -c\ -Wall\ -Wextra\ -o\ /dev/null\ %
autocmd FileType c set autowrite

" ============================================================================
" Perl
" ============================================================================
" syntax color complex things like @{${"foo"}}
autocmd FileType perl let perl_extended_vars = 1

" my perl includes pod
autocmd FileType perl let perl_include_pod = 1

" Folding for perl
let perl_fold=1

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -wc\ %
autocmd FileType perl set errorformat+=%m\ at\ %f\ line\ %l\.
autocmd FileType perl set errorformat+=%m\ at\ %f\ line\ %l
autocmd FileType perl set autowrite

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

" Tidy select lines (or entire file) with _t
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _T :!perltidy  -q<Enter>

" ============================================================================
" PHP
" ============================================================================
autocmd FileType php set makeprg=php\ -l\ %
autocmd FileType php set autowrite

" ============================================================================
" Load plugin bunbles with pathogen
" ============================================================================
execute pathogen#infect()

" ============================================================================
" set color scheme
" ============================================================================
colorscheme molokai

