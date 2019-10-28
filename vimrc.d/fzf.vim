if !executable('fzf')
  finish
endif

if isdirectory('/usr/local/opt/fzf')
  set runtimepath+=/usr/local/opt/fzf
endif

nnoremap <silent> <leader>z :Buffers<CR>
nnoremap <silent> <leader>x :GFiles<CR>
nnoremap <silent> <leader>c :Files<CR>
