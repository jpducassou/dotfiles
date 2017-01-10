" Vim compiler file
" Compiler:         perl testing compiler
" Maintainer:       Jean Pierre Ducassou


if exists("current_compiler")
  finish
endif
let current_compiler = "prove"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=prove
" CompilerSet errorformat=

let &cpo = s:cpo_save
unlet s:cpo_save

