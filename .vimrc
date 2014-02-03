" ============================================================================
" General
" ============================================================================
" use vim defaults
set nocompatible

" allways show status line
set ls=2

" syntax highlighting
set bg=dark
set t_Co=256 " para que use todos los colores de la consola
syntax on

" Chuck Norris programing
set tabstop=2
set shiftwidth=2

" Show title in console title bar
set title

" turn off visual bell
set visualbell t_vb=
set novisualbell

" do not keep a backup file
set nobackup

" NoMatchParen
au vimEnter * NoMatchParen

" set color scheme
colorscheme molokai

" dont use Q for Ex mode
map Q :q

" Toggle line numbers on/off
map <F2> :set number!<CR>

" Toggle line numbers on/off
map <F5> :set list!<CR>

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

" ============================================================================
" Perl
" ============================================================================
" show line numbers
autocmd FileType perl set number

" syntax color complex things like @{${"foo"}}
autocmd FileType perl let perl_extended_vars = 1

" my perl includes pod
autocmd FileType perl let perl_include_pod = 1

" Folding for perl
let perl_fold=1

autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldnestmax=1
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR

" check perl code with :make
autocmd FileType perl set makeprg=perl\ -c\ %\ $*
autocmd FileType perl set errorformat=%f:%l:%m

" comment/uncomment blocks of code (in vmode)
vmap _c :s/^/#/gi<Enter>
vmap _C :s/^#//gi<Enter>

" run current file as a test
nmap _v :!clear && clear && prove -vw %

" Tidy select lines (or entire file) with _t
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _T :!perltidy  -q<Enter>

" ============================================================================
" Java & XML
" ============================================================================
autocmd FileType java,xml,xhtml set makeprg=mvn
autocmd FileType java,xml,xhtml set tabstop=4
autocmd FileType java,xml,xhtml set shiftwidth=4
autocmd FileType java,xml,xhtml set expandtab

" ============================================================================
" Searching
" ============================================================================
"Usually I don't care about case when searching
set ignorecase

"Only ignore case when we type lower case when searching
set smartcase

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" ============================================================================
" Wildmenu
" ============================================================================
"Show menu with possible tab completions
set wildmenu
set wildmode=list:longest,full

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
" ============================================================================
" Set configuration file to apache style
autocmd BufNewFile,BufRead *.conf if empty(&syntax) | set filetype=apache | endif

