" vim-lsp
let g:lsp_text_edit_enabled = 0
let g:lsp_async_completion = 1
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_signs_error = {'text': '!!'}
let g:lsp_signs_warning = {'text': '! '}
let g:lsp_signs_information = {'text': 'i '}
let g:lsp_signs_hint = {'text': '? '}

let g:lsp_preview_keep_focus = 1

" golang
if executable('gopls')
  augroup LspGo
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'golang',
      \ 'cmd': ['gopls', 'serve'],
      \ 'initialization_options': {
      \   'completeUnimported': v:true,
      \   'usePlaceholders': v:true,
      \   'staticcheck': v:true,
      \   'completionDocumentation': v:true,
      \   'caseSensitiveCompletion': v:true,
      \ },
      \ 'whitelist': ['go'],
      \ })

    autocmd FileType go setlocal omnifunc=lsp#complete

    autocmd FileType go nmap <buffer><silent> gd        <plug>(lsp-definition)
    autocmd FileType go nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
    autocmd FileType go nmap <buffer><silent> gD        <plug>(lsp-references)
    autocmd FileType go nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    autocmd FileType go nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
    autocmd FileType go nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    autocmd FileType go nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    autocmd FileType go nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
    autocmd FileType go nmap <buffer><silent> <leader>n <plug>(lsp-rename)
    autocmd FileType go nmap <buffer><silent> <leader>a <plug>(lsp-code-action)
    autocmd FileType go nmap <buffer><silent> <leader>e <plug>(lsp-next-error)

    autocmd FileType go autocmd CursorHold <buffer> LspHover
    autocmd FileType go autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif

" Rust
if executable('rls')
  augroup LspRust
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'rls',
      \ 'cmd': ['rustup', 'run', 'stable', 'rls'],
      \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
      \ 'whitelist': ['rust'],
      \ })

    autocmd FileType rust setlocal omnifunc=lsp#complete

    autocmd FileType rust nmap <buffer><silent> gd        <plug>(lsp-definition)
    autocmd FileType rust nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
    autocmd FileType rust nmap <buffer><silent> gD        <plug>(lsp-references)
    autocmd FileType rust nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    autocmd FileType rust nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
    autocmd FileType rust nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    autocmd FileType rust nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    autocmd FileType rust nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
    autocmd FileType rust nmap <buffer><silent> <leader>n <plug>(lsp-rename)
    autocmd FileType rust nmap <buffer><silent> <leader>a <plug>(lsp-code-action)
    autocmd FileType rust nmap <buffer><silent> <leader>e <plug>(lsp-next-error)

    autocmd FileType rust autocmd CursorHold <buffer> LspHover
    autocmd FileType rust autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif

" Python
if executable('pyls')
  augroup LspPython
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'pyls',
      \ 'cmd': ['pyls'],
      \ 'whitelist': ['python'],
      \ })

    autocmd FileType python setlocal omnifunc=lsp#complete

    autocmd FileType python nmap <buffer><silent> gd        <plug>(lsp-definition)
    autocmd FileType python nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
    autocmd FileType python nmap <buffer><silent> gD        <plug>(lsp-references)
    autocmd FileType python nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    autocmd FileType python nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
    autocmd FileType python nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    autocmd FileType python nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    autocmd FileType python nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
    autocmd FileType python nmap <buffer><silent> <leader>n <plug>(lsp-rename)
    autocmd FileType python nmap <buffer><silent> <leader>a <plug>(lsp-code-action)
    autocmd FileType python nmap <buffer><silent> <leader>e <plug>(lsp-next-error)

    autocmd FileType python autocmd CursorHold <buffer> LspHover
    autocmd FileType python autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif

" TypeScript
if executable('javascript-typescript-stdio')
  augroup LspTypeScript
    autocmd!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript',
          \ 'cmd': ['javascript-typescript-stdio'],
          \ 'whitelist': ['typescript', 'typescript.tsx'],
          \ })

    autocmd FileType typescript setlocal omnifunc=lsp#complete

    autocmd FileType typescript nmap <buffer><silent> gd        <plug>(lsp-definition)
    autocmd FileType typescript nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
    autocmd FileType typescript nmap <buffer><silent> gD        <plug>(lsp-references)
    autocmd FileType typescript nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    autocmd FileType typescript nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
    autocmd FileType typescript nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    autocmd FileType typescript nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    autocmd FileType typescript nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
    autocmd FileType typescript nmap <buffer><silent> <leader>n <plug>(lsp-rename)
    autocmd FileType typescript nmap <buffer><silent> <leader>a <plug>(lsp-code-action)
    autocmd FileType typescript nmap <buffer><silent> <leader>e <plug>(lsp-next-error)

    autocmd FileType typescript autocmd CursorHold <buffer> LspHover
    autocmd FileType typescript autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif
