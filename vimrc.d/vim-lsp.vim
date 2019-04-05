" vim-lsp

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

    autocmd FileType go autocmd CursorHold <buffer> LspHover
    autocmd FileType go autocmd BufWritePre <buffer> LspDocumentFormatSync
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

    autocmd FileType python autocmd CursorHold <buffer> LspHover
    autocmd FileType python autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif

" TypeScript
if executable('typescript-language-server')
  augroup LspTypeScript
    autocmd!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'typescript-language-server',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
          \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
          \ 'whitelist': ['typescript', 'typescript.tsx'],
          \ })

    autocmd FileType typescript setlocal omnifunc=lsp#complete

    autocmd FileType typescript nmap <buffer><silent> gd        <plug>(lsp-definition)
    autocmd FileType typescript nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
    autocmd FileType typescript nmap <buffer><silent> gD        <plug>(lsp-references)
    autocmd FileType typescript nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    autocmd FileType typescript nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
    autocmd FileType typescript nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    "autocmd FileType typescript nmap <buffer><silent> <leader>k <plug>(lsp-hover)
    autocmd FileType typescript nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
    autocmd FileType typescript nmap <buffer><silent> <leader>n <plug>(lsp-rename)

    "autocmd FileType typescript autocmd CursorHold <buffer> LspHover
    autocmd FileType typescript autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END
endif
