" ============================================================================
" Perl
" ============================================================================
" my perl includes pod
let perl_include_pod = 1

" Folding for perl
let perl_fold = 1

" Syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Use more context for highlighting
let perl_sync_dist = 250

" Adjust keyword characters to match Perlish identifiers
set iskeyword+=$
set iskeyword+=%
set iskeyword+=@-@
set iskeyword+=:
set iskeyword-=,

" Match angle brackets...
set matchpairs+=<:>,«:»

" Template toolkit 2 config
" au BufNewFile,BufRead *.tmpl.html setf tt2html
let b:tt2_syn_tags = '\[% %] <!-- -->'

