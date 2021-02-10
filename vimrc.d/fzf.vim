if !executable('fzf')
  finish
endif

let s:fzf_dirs = [
      \ '/usr/local/opt/fzf',
      \ '/opt/homebrew/opt/fzf',
      \ ]

for fzf_dir in s:fzf_dirs
  if isdirectory(fzf_dir)
    let &runtimepath .= ',' . fzf_dir
  endif
endfor

nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>f :Files<CR>
