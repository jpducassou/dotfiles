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

" No wrapping of lines
set nowrap

" do not keep a backup file
set nobackup

" allways show status line
set ls=2

" Allow pattern matching with special characters (ie: newline)
set magic

" airline
let g:airline_powerline_fonts = 0
let g:airline_left_sep  = ''
let g:airline_right_sep = ''

" To override statusline theme
let g:airline_theme = 'lucius'

" NoMatchParen
" au vimEnter * NoMatchParen

" dont use Q for Ex mode
map Q :q<CR>

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

" Numbering by default
set number
if v:version >= 703
	set relativenumber
endif

" ============================================================================
" F2 - F4
" ============================================================================
" Toggle line numbers on/off
function! ToggleNumber()
	set number!
	if v:version >= 703
		set relativenumber!
	endif
endfunction
map <F2> :call ToggleNumber()<CR>

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
" Indentation
" ============================================================================
" Enable smartindend
set autoindent
set smartindent

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

" Ctrl + space turns on omni completion
inoremap <C-@> <C-x><C-o>

" ctags
set tags=./.tags,.tags;$HOME

" ============================================================================
" F5 - F8
" ============================================================================
" Compile or run test when <F5> is pressed
nmap <F5> :<C-U>make %<CR>

" Automatically open, but do not go (if there are errors) to the quickfix
augroup OpenQuickfixWindowAfterMake
	autocmd QuickFixCmdPost [^l]* nested cwindow
	autocmd QuickFixCmdPost    l* nested lwindow
augroup END

" Execute the script whatever that means
nmap <F6> :!%:p<CR>

" Lint the whole file
nmap <F7> gg=G

" turn on 4-space
map <F8> :set tabstop=4 shiftwidth=4 expandtab<CR>

" ============================================================================
" Templates for new files
" ============================================================================
augroup New_File_Setup
	autocmd!
	autocmd BufNewFile  *  -1r !vim_file_template <afile>
	autocmd BufNewFile  *  :silent call search('^[ \t]*[#"].*implementation[ \t]\+here')
	autocmd BufNewFile  *  :redraw
augroup END

" ============================================================================
" Search folding
" ============================================================================
" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})

" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'

augroup FoldSub
	autocmd!
	autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
	autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
	autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
	autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
	autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only 'use' statements
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})

" ============================================================================
" Set paste mode
" ============================================================================
set paste

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


