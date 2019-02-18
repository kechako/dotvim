" vim-lsp

" golang
if executable('gopls') || executable('go-langserver')
  augroup LspGo
    autocmd!
    if executable('gopls')
      autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'go-lang',
            \ 'cmd': {server_info->['gopls', 'serve']},
            \ 'whitelist': ['go'],
            \ })
    elseif executable('go-langserver')
      autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'go-lang',
            \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
            \ 'initialization_options': {
            \   'funcSnippetEnabled': v:true,
            \   'gocodeCompletionEnabled': v:true,
            \   'formatTool': 'goimports',
            \   'lintTool': 'golint',
            \   'goimportsLocalPrefix': '',
            \   'diagnosticsEnabled': v:true
            \ },
            \ 'whitelist': ['go'],
            \ })
    endif

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

    autocmd CursorHold *.go LspHover

    let g:lsp_signs_enabled = 1
    let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_signs_error = {'text': '!!'}
    let g:lsp_signs_warning = {'text': '! '}
    let g:lsp_signs_information = {'text': 'i '}
    let g:lsp_signs_hint = {'text': '? '}

    let g:lsp_preview_keep_focus = 1
  augroup END
endif
