let NERDTreeIgnore = ['.meta$', '\~$']

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeVCS | endif

" 他のバッファーが閉じられ、NERDTree のバッファーが最後の一つの場合、
" NERDTree のバッファーを閉じる
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

nnoremap <leader>t :NERDTreeToggleVCS<CR>
