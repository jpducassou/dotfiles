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
autocmd FileType perl set keywordprg=perldoc\ -f
autocmd FileType perl set equalprg=perltidy
autocmd FileType perl set errorformat+=%m\ at\ %f\ line\ %l
autocmd FileType perl set autowrite

" Tidy select lines (or entire file) with _t
nnoremap <silent> _t :%!perltidy -q<Enter>
vnoremap <silent> _T :!perltidy  -q<Enter>

" Template toolkit 2 config
" au BufNewFile,BufRead *.tmpl.html setf tt2html
let b:tt2_syn_tags = '\[% %] <!-- -->'

