" ============================================================================
" General
" ============================================================================
" use vim defaults
set nocompatible

" syntax highlighting
syntax on

" Enable omnifunc
filetype plugin on

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

" allways show status line
set ls=2

" Allow pattern matching with special characters (ie: newline)
set magic

" airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep  = ''
let g:airline_right_sep = ''

" To override statusline theme
let g:airline_theme = 'lucius'

" NoMatchParen
au vimEnter * NoMatchParen

" Vim paste mode to avoid destruction of pasted text
" set pastetoggle=<F2>
set paste

" dont use Q for Ex mode
map Q :q

" dragvisuals config
vmap  <expr>  <C-S-h>  DVB_Drag('left')
vmap  <expr>  <C-S-l>  DVB_Drag('right')
vmap  <expr>  <C-S-j>  DVB_Drag('down')
vmap  <expr>  <C-S-k>  DVB_Drag('up')

" ============================================================================
" Insert a new-line after the current line by pressing Enter.
" Ctrl-o for inserting a line before the current line.
" Ctrl-J split line on next character
" ============================================================================
nmap <CR> o<Esc>
nmap <C-o> O<Esc>
nnoremap <C-J> a<CR><Esc>k

" ============================================================================
" F2 - F5
" ============================================================================
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

" Toggle display tabs & spaces on/off
map <F4> :set list!<CR>

" ============================================================================
" Toggle indentation style
" ============================================================================
" turn on 4-space
map <F8> :set tabstop=4 shiftwidth=4 expandtab<CR>

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

" Insert spaces in block mode
vnoremap <space> I<space><esc>gv
" FIXME:
" vnoremap <bs>    :s/^.//<esc>gv

" ============================================================================
" Searching
" ============================================================================
" Usually I don't care about case when searching
set ignorecase

" Only ignore case when we type lower case when searching
set smartcase

" shortcut for :%s///g
nmap S :%s//g<LEFT><LEFT>

" ============================================================================
" Wildmenu
" ============================================================================
" Show menu with possible tab completions
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc

" Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7

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

nmap <F5> :<C-U>make %<CR>

" Ctrl + space turns on omni completion
inoremap <C-@> <C-x><C-o>

" ctags
set tags=./.tags,.tags;$HOME

" ============================================================================
" Load plugin bunbles with pathogen
" ============================================================================
execute pathogen#infect()

" ============================================================================
" set color scheme
" ============================================================================
colorscheme molokai

" ============================================================================
" Visual aid
" ============================================================================
" Make tabs, trailing whitespace, and non-breaking look nicer
exec "set listchars=tab:\uBB\uBB,nbsp:~"

" Make the 81st column stand out
if v:version >= 702
	highlight ColorColumn ctermbg=magenta
	call matchadd('ColorColumn', '\%81v', 100)
endif

" Create a highlight group for ws:
highlight ExtraWhitespace ctermbg=red guibg=red

" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL


