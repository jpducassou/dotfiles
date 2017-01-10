" check perl code with :make
" autocmd FileType perl setlocal makeprg=perl\ -wc\ %
" autocmd FileType perl setlocal keywordprg=perldoc\ -f
" autocmd FileType perl setlocal equalprg=perltidy
" autocmd FileType perl setlocal errorformat+=%m\ at\ %f\ line\ %l
" autocmd FileType perl setlocal autowrite

compiler perl

