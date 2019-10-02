if !executable('fzf')
  finish
endif

if isdirectory('/usr/local/opt/fzf')
  set runtimepath+=/usr/local/opt/fzf
endif

nmap <buffer><silent> <leader>z :Buffers<CR>
nmap <buffer><silent> <leader>x :GFiles<CR>
nmap <buffer><silent> <leader>c :Files<CR>
