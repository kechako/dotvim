" ハイライトを自動で設定しない
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2a3158 ctermbg=237
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#1e2132 ctermbg=235
