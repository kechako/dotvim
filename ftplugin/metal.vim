" Vim filetype plugin file
" Language: Apple Metal Shading Language v2.1
" Maintainer:	Ryosuke Akiyama <r@554.jp>
" Last Change: 2020 Aug 18

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" Behaves mostly just like C++
runtime! ftplugin/cpp.vim
