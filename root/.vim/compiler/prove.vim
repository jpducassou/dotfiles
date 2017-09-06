" Vim compiler file
" Compiler:         perl testing compiler
" Maintainer:       Jean Pierre Ducassou
" Based on https://github.com/vim-scripts/perlprove.vim/blob/master/compiler/perlprove.vim

if exists("current_compiler")
  finish
endif
let current_compiler = "prove"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=prove\ -l\ -v

let &cpo = s:cpo_save
unlet s:cpo_save

