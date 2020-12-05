let g:fern#renderer = 'nerdfont'

function s:fern_setup() abort
  nnoremap <buffer> <nowait> <silent> q :<c-u>quit<cr>
  nmap <buffer>
    \ <Plug>(fern-action-open)
    \ <Plug>(fern-action-open:select)
endfunction

function s:can_open_fern() abort
  if argc() == 1 && argv(0) == ".git/COMMIT_EDITMSG"
    return v:false
  endif

  if argc() == 1 && argv(0) == ".git/rebase-merge/git-rebase-todo"
    return v:false
  endif

  if exists("s:std_in")
    return v:false
  endif

  return v:true
endfunction

augroup __fern__
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * ++nested if s:can_open_fern() | Fern . -drawer -stay -toggle -reveal=% | endif
  autocmd FileType fern call s:fern_setup()
augroup END

nnoremap <silent> <leader>t :<c-u>Fern . -drawer -stay -toggle -reveal=%<cr>
