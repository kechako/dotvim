function s:setup_make_settings()
  " バッファーで開いているファイルと同じディレクトリの
  " Makefile のパスを取得
  let l:makefile = expand("%:p:h") . '/Makefile'

  if filereadable(l:makefile)
    " Makefile が存在するので make をそのまま使用する
    return
  endif

  " :make 実行時に go build を実行する go build コマンドは複数パッケージを指定す
  " ると出力を破棄するので、errors を指定して破棄する。
  " Vim のカレントディレクトリと Go のビルドディレクトリが異なることがあるので、
  " カレントディレクトリを変更し、ビルドディレクトリを出力した後で、go build を
  " 実行する。出力したビルドディレクトリは、errorformat オプションにて補足し、
  " QuickFix でディレクトリの変更を含めた形で出力できるようにする。
  let &l:makeprg = "(cd %:p:h; echo \"Working dir '$(pwd)'\"; go build . errors)"
  " Working dir '[build path]'
  " [filename]:[line]:[column]: [message]
  let &l:errorformat="%f:%l:%c: %m,%DWorking dir '%f'"
endfunction

augroup __go__
  autocmd!
  autocmd FileType go call s:setup_make_settings()
augroup END
