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

function s:lsp_common_settings(opts)
  let l:opts = {
    \   'def':    v:true,
    \   'ref':    v:true,
    \   'symbol': v:true,
    \   'format': v:true,
    \   'hover':  v:true,
    \   'impl':   v:true,
    \   'ren':    v:true,
    \   'action': v:true,
    \   'nerror': v:true,
    \ }
  call extend(l:opts, a:opts)

  setlocal omnifunc=lsp#complete

  if l:opts['def']
    nmap <buffer><silent> gd        <plug>(lsp-definition)
    nmap <buffer><silent> <C-]>     <plug>(lsp-definition)
  endif

  if l:opts['ref']
    nmap <buffer><silent> gD        <plug>(lsp-references)
  endif

  if l:opts['symbol']
    nmap <buffer><silent> <leader>s <plug>(lsp-document-symbol)
    nmap <buffer><silent> <leader>y <plug>(lsp-workspace-symbol)
  endif

  if l:opts['format']
    nmap <buffer><silent> <leader>f <plug>(lsp-document-format)
    autocmd BufWritePre <buffer> LspDocumentFormatSync
  endif

  if l:opts['hover']
  nmap <buffer><silent> <leader>k <plug>(lsp-hover)
  autocmd CursorHold <buffer> LspHover
  endif

  if l:opts['impl']
    nmap <buffer><silent> <leader>i <plug>(lsp-implementation)
  endif

  if l:opts['ren']
    nmap <buffer><silent> <leader>n <plug>(lsp-rename)
  endif

  if l:opts['action']
    nmap <buffer><silent> <leader>a <plug>(lsp-code-action)
  endif

  if l:opts['nerror']
    nmap <buffer><silent> <leader>e <plug>(lsp-next-error)
  endif
endfunction

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

    autocmd FileType go call s:lsp_common_settings({})

    autocmd FileType go autocmd BufWritePre <buffer> 
      \ call execute('LspCodeActionSync source.organizeImports')
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

    autocmd FileType rust call s:lsp_common_settings({})
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

    autocmd FileType python call s:lsp_common_settings({})
  augroup END
endif

" TypeScript & JavaScript
if executable('javascript-typescript-stdio')
  augroup LspTsJs
    autocmd!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'tsjs',
          \ 'cmd': ['javascript-typescript-stdio'],
          \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), ['tsconfig.json', 'package.json', '.git/']))},
          \ 'whitelist': [
          \   'typescript',
          \   'javascript',
          \   'typescriptreact',
          \   'javascriptreact',
          \ ],
          \ })

    autocmd FileType typescript      call s:lsp_common_settings({'format': v:false})
    autocmd FileType javascript      call s:lsp_common_settings({'format': v:false})
    autocmd FileType typescriptreact call s:lsp_common_settings({'format': v:false})
    autocmd FileType javascriptreact call s:lsp_common_settings({'format': v:false})
  augroup END
endif

" swift
let $TOOLCHAINS = "swift"
if executable('sourcekit-lsp')
  augroup LspSwift
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'swift',
      \ 'cmd': ['sourcekit-lsp'],
      \ 'whitelist': ['swift'],
      \ })

    autocmd FileType swift call s:lsp_common_settings({})
  augroup END
endif
