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

    autocmd FileType go nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
    autocmd FileType go nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType go nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>s :<C-u>LspDocumentSymbol<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>y :<C-u>LspWorkspaceSymbol<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>f :<C-u>LspDocumentFormat<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>k :<C-u>LspHover<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>i :<C-u>LspImplementation<CR>
    autocmd FileType go nnoremap <buffer><silent> <leader>n :<C-u>LspRename<CR>

    autocmd FileType go autocmd CursorHold LspHover
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

    autocmd FileType python nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
    autocmd FileType python nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType python nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>s :<C-u>LspDocumentSymbol<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>y :<C-u>LspWorkspaceSymbol<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>f :<C-u>LspDocumentFormat<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>k :<C-u>LspHover<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>i :<C-u>LspImplementation<CR>
    autocmd FileType python nnoremap <buffer><silent> <leader>n :<C-u>LspRename<CR>

    autocmd FileType python autocmd CursorHold LspHover
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

    autocmd FileType typescript nnoremap <buffer><silent> gd :<C-u>LspDefinition<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    autocmd FileType typescript nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <leader>s :<C-u>LspDocumentSymbol<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <leader>y :<C-u>LspWorkspaceSymbol<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <leader>f :<C-u>LspDocumentFormat<CR>
    "autocmd FileType typescript nnoremap <buffer><silent> <leader>k :<C-u>LspHover<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <leader>i :<C-u>LspImplementation<CR>
    autocmd FileType typescript nnoremap <buffer><silent> <leader>n :<C-u>LspRename<CR>

    "autocmd CursorHold *.ts LspHover
  augroup END
endif
