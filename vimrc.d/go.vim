" vim-go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_mod_fmt_autosave = 1
let g:go_metalinter_autosave = 0
let g:go_def_mapping_enabled = 0

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

if has("autocmd")
  augroup VimGo
    autocmd!

    autocmd FileType go nmap <leader>b  <Plug>(go-build)
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    autocmd FileType go nmap <Leader>c  <Plug>(go-coverage-toggle)
    autocmd FileType go nmap <Leader>I  <Plug>(go-info)
  augroup END
endif
