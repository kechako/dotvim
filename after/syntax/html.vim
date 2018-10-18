if exists("b:did_syntax") | finish | endif
let b:did_syntax = 1

let s:cpo_save = &cpo
set cpo&vim

syntax sync minlines=500 maxlines=1000
