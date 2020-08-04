function s:build_plugins_helptag() abort
  let l:docs = finddir('doc', expand('~/.vim/pack/plugins/start') . '/*/', -1)

  if empty(l:docs)
    return
  endif

  for doc in l:docs
    helptags `=fnamemodify(doc, ':p')`
  endfor
endfunction

command! BuildPluginsHelpTag call s:build_plugins_helptag()
