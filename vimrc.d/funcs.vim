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

function s:switch_addtags_transform() abort
  if exists('g:go_addtags_transform')
    if g:go_addtags_transform != 'camelcase'
      let g:go_addtags_transform = 'camelcase'
      echo 'switch to camelCase'
    else
      unlet g:go_addtags_transform
      echo 'switch to snake_case'
    endif
  else
    let g:go_addtags_transform = 'camelcase'
    echo 'switch to camelCase'
  endif
endfunction

command! SwitchAddTagsTransform call s:switch_addtags_transform()
