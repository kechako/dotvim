" insert mode でバックスペースで削除可能な文字の設定
set backspace=indent,eol,start
" スワップファイルを作成
set swapfile
set directory=$HOME/.vim/swap
" バックアップファイルを作成
set backup
set backupdir=$HOME/.vim/backup
" undo ファイルを作成
set undofile
set undodir=$HOME/.vim/undo
" コマンドライン履歴を50行保存
set history=50
" カーソル位置を常時表示
set ruler
" カーソル行をハイライト
set cursorline
" タブを常時表示
set showtabline=2
" 画面上下のスクロール開始位置のオフセット
set scrolloff=3
" 入力中のコマンドを表示
set showcmd
" バッファー切替時に hidden にする
set hidden
" インクリメタルサーチを実行
set incsearch
" ステータス行の表示
set laststatus=2
" ファイルの末尾に自動で改行を入れない
set nofixendofline
" 補完の一覧表示
set wildmenu
set wildmode=list:full
" 曖昧な幅の文字を double width で表示
set ambiwidth=double
" netrw にてファイル名、サイズ、タイムスタンプをデフォルト表示
let g:netrw_liststyle=1
" .netrwhist 及び .netrwbook の格納場所
let g:netrw_home=expand("$HOME/.vim/netrw")
" quickfix
set switchbuf=usetab,newtab
" コマンドラインの高さ
set cmdheight=4
" ビープを鳴らさない
set vb t_vb=
" preview を削除する
" vim-go の auto completion で不要な Preview が表示されるのを抑制する
set completeopt-=preview
" leader に ',' を設定
let mapleader = ","

" grep プログラム設定
if executable('jvgrep')
  set grepprg=jvgrep
endif
" grep を silent で実行する Grep コマンドを定義
command! -nargs=+ Grep execute 'silent grep! <args>'

" 非表示文字の設定
set list
set listchars=tab:\ \ ,trail:-,nbsp:%

" rtf-highlight の設定
let g:rtfh_theme = 'bright'
let g:rtfh_font = 'Menlo'
let g:rtfh_size = '24'

" モード変更時にカーソルを変更する設定
if &term =~ 'xterm\|screen'
  let &t_ti .= "\e[1 q" " termcap mode に入った時
  let &t_SI .= "\e[5 q" " insert mode に入った時
  let &t_EI .= "\e[1 q" " insert mode を抜けた時
  let &t_te .= "\e[0 q" " termcap mode を抜けた時
endif

" マウス
if has('mouse')
  set mouse=a
endif

" カラー表示可能かどうかチェック
if &t_Co > 2 || has("gui_running")
  " シンタックスハイライトを on
  syntax on
  " 検索時のハイライト表示を on
  set hlsearch
  " カラーテーマ設定
  set background=dark
  colorscheme solarized
  " lightline.vim
  let g:lightline = {
    \ 'active':{
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'charinfo', 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component': {
    \   'charinfo': 'U+%04B'
    \ },
    \ 'component_function': {
    \   'filetype': 'LightLineFiletype',
    \   'fileformat': 'LightLineFileformat'
    \ },
    \ 'colorscheme': 'solarized'
    \ }
  function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction
  function! LightLineFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction
endif

" クリップボードが有効な場合
if has("clipboard")
  " Yank と Clipboard を連携
  set clipboard=unnamedplus,unnamed
endif

" autocmd が有効な場合
if has("autocmd")
  " ファイルタイプの検出を有効にする
  " ファイルタイププラグインを使用する
  " インデントファイルを使う
  filetype plugin indent on

  " quickfix を自動で開く設定
  augroup QuickFixCmd
    autocmd!
    autocmd QuickFixCmdPost *grep*,make cwindow
  augroup END

  " カーソル位置を復元する設定
  augroup RestoreCursorPos
    autocmd!

    " ファイルを開いた時に、前回のカーソル位置に移動する
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

else

  " autoindent を設定
  set autoindent

endif " has("autocmd")

if has('quickfix')
  map <C-j> :cnext<CR>
  map <C-k> :cprevious<CR>
  nnoremap <leader>a :cclose<CR>
endif

if has('langmap') && exists('+langnoremap')
  " langmap の文字がマッピングの結果として適用されないようにする
  " (このオプションは後方互換性のためデフォルトはOFF)
  set langnoremap
endif

" vim-go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

let g:go_auto_type_info = 1

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
    autocmd FileType go nmap <Leader>i  <Plug>(go-info)
  augroup END
endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" typescript-vim
let g:typescript_indent_disable = 1

" vim-gfm-syntax
let g:markdown_fenced_languages = ['go', 'ruby']
let g:gfm_syntax_emoji_conceal = 1

let g:tagbar_left = 0
let g:tagbar_autofocus = 1

" TwitVim
let twitvim_enable_ruby = 1
