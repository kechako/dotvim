function s:setup_make_settings()
  " バッファーで開いているファイルと同じディレクトリの
  " Makefile のパスを取得
  let l:makefile = expand("%:p:h") . '/Makefile'

  if filereadable(l:makefile)
    " Makefile が存在するので make をそのまま使用する
    return
  endif

  " :make 実行時に go build を実行する
  " go build コマンドは複数パッケージを指定すると
  " 出力を破棄するので、errors を指定して破棄する
  setlocal makeprg=(cd\ %:p:h\ &&\ go\ build\ .\ errors)
  " [filename]:[line]:[column]: [message]
  setlocal errorformat=%f:%l:%c:\ %m
endfunction

autocmd FileType go call s:setup_make_settings()
