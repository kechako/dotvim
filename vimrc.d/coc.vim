" coc.nvim

" common functions
function! s:show_documentation()
  call CocAction('doHover')
endfunction

" golang
augroup LspGo
  autocmd!

  autocmd FileType go nmap <buffer><silent> gd        <plug>(coc-definition)
  autocmd FileType go nmap <buffer><silent> <C-]>     <plug>(coc-definition)
  autocmd FileType go nmap <buffer><silent> gD        <plug>(coc-references)
  autocmd FileType go nmap <buffer><silent> <leader>f <plug>(coc-format)
  autocmd FileType go nmap <buffer><silent> <leader>k :call <SID>show_documentation()<CR>
  autocmd FileType go nmap <buffer><silent> <leader>i <plug>(coc-implementation)
  autocmd FileType go nmap <buffer><silent> <leader>n <plug>(coc-rename)
  autocmd FileType go nmap <buffer><silent> <leader>a <plug>(coc-codeaction)

  autocmd FileType go autocmd CursorHold <buffer> :call s:show_documentation()
  "autocmd FileType go autocmd BufWritePre <buffer> :call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

" Rust
augroup LspRust
  autocmd!

  autocmd FileType rust nmap <buffer><silent> gd        <plug>(coc-definition)
  autocmd FileType rust nmap <buffer><silent> <C-]>     <plug>(coc-definition)
  autocmd FileType rust nmap <buffer><silent> gD        <plug>(coc-references)
  autocmd FileType rust nmap <buffer><silent> <leader>f <plug>(coc-format)
  autocmd FileType rust nmap <buffer><silent> <leader>k :call <SID>show_documentation()<CR>
  autocmd FileType rust nmap <buffer><silent> <leader>i <plug>(coc-implementation)
  autocmd FileType rust nmap <buffer><silent> <leader>n <plug>(coc-rename)
  autocmd FileType rust nmap <buffer><silent> <leader>a <plug>(coc-codeaction)

  autocmd FileType rust autocmd CursorHold <buffer> :call s:show_documentation()
augroup END

" Python
augroup LspPython
  autocmd!

  autocmd FileType python nmap <buffer><silent> gd        <plug>(coc-definition)
  autocmd FileType python nmap <buffer><silent> <C-]>     <plug>(coc-definition)
  autocmd FileType python nmap <buffer><silent> gD        <plug>(coc-references)
  autocmd FileType python nmap <buffer><silent> <leader>f <plug>(coc-format)
  autocmd FileType python nmap <buffer><silent> <leader>k :call <SID>show_documentation()<CR>
  autocmd FileType python nmap <buffer><silent> <leader>i <plug>(coc-implementation)
  autocmd FileType python nmap <buffer><silent> <leader>n <plug>(coc-rename)
  autocmd FileType python nmap <buffer><silent> <leader>a <plug>(coc-codeaction)

  autocmd FileType python autocmd CursorHold <buffer> :call s:show_documentation()
augroup END

" TypeScript
augroup LspTypeScript
  autocmd!

  autocmd FileType typescript nmap <buffer><silent> gd        <plug>(coc-definition)
  autocmd FileType typescript nmap <buffer><silent> <C-]>     <plug>(coc-definition)
  autocmd FileType typescript nmap <buffer><silent> gD        <plug>(coc-references)
  autocmd FileType typescript nmap <buffer><silent> <leader>f <plug>(coc-format)
  autocmd FileType typescript nmap <buffer><silent> <leader>k :call <SID>show_documentation()<CR>
  autocmd FileType typescript nmap <buffer><silent> <leader>i <plug>(coc-implementation)
  autocmd FileType typescript nmap <buffer><silent> <leader>n <plug>(coc-rename)
  autocmd FileType typescript nmap <buffer><silent> <leader>a <plug>(coc-codeaction)

  autocmd FileType typescript autocmd CursorHold <buffer> :call s:show_documentation()
augroup END
