if !executable('fzf')
  finish
endif

if isdirectory('/usr/local/opt/fzf')
  set runtimepath+=/usr/local/opt/fzf
endif

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>f :Files<CR>
