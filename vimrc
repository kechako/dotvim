" vim:set fenc=utf-8 ff=unix

" encoding
set encoding=utf-8

" insert mode でバックスペースで削除可能な文字の設定
set backspace=indent,eol,start

let $XDG_CACHE_HOME = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let $XDG_STATE_HOME = empty($XDG_STATE_HOME) ? expand('~/.local/state') : $XDG_STATE_HOME
let $XDG_DATA_HOME = empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

" viminfo
set viminfofile=$XDG_STATE_HOME/vim/viminfo
" スワップファイル
set directory=$XDG_STATE_HOME/vim/swap//
" バックアップファイル
set backupdir=$XDG_STATE_HOME/vim/backup//
" Undo ファイル
set undodir=$XDG_DATA_HOME/vim/undo//
" 各ディレクトリが存在しない場合は自動作成
call mkdir(&directory, 'p')
call mkdir(&backupdir, 'p')
call mkdir(&undodir, 'p')
" 機能を有効化
set swapfile
set backup
set undofile

" 日本語 Help を優先する
set helplang=ja,en
" コマンドライン履歴を50行保存
set history=1000
" カーソル位置を常時表示
set ruler
" カーソル行をハイライト
set cursorline
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
" 検索件数の表示
set shortmess-=S
" ファイルの末尾に自動で改行を入れない
set nofixendofline
" 補完の一覧表示
set wildmenu
set wildoptions=pum
" 曖昧な幅の文字を single width で表示
set ambiwidth=single
" netrw にてファイル名、サイズ、タイムスタンプをデフォルト表示
let g:netrw_liststyle=1
" .netrwhist 及び .netrwbook の格納場所
let g:netrw_home=$XDG_DATA_HOME .. '/vim/netrw'
" コマンドラインの高さ
set cmdheight=4
" 行番号
set number
set numberwidth=6
" 行番号を相対表示する
set relativenumber
" ビープを鳴らさない
set vb t_vb=
" Leader に '<Space>' を設定
let mapleader = "\<Space>"
" LocalLeader に '' を設定
let maplocalleader = "\\"
" キーコードの待ち時間を50msに設定
set ttimeoutlen=50
" C-A や C-X によるインクリメント、デクリメントで負号を無視する
set nrformats+=unsigned

set fillchars+=vert:│
set fillchars+=fold:─

" <C-p>, <C-n> による履歴の参照の動作を <Up>, <Down> に合わせる
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" 折り返し行のカーソル移動を簡単にする
nmap gj gj<SID>g
nmap gk gk<SID>g
nnoremap <script> <SID>gj gj<SID>g
nnoremap <script> <SID>gk gk<SID>g
nnoremap <script> <SID>gq <Nop>
nmap <SID>g <Nop>

" 画面サイズの変更を簡単にする
nmap <C-w>+ <C-w>+<SID>ws
nmap <C-w>- <C-w>-<SID>ws
nmap <C-w>> <C-w>><SID>ws
nmap <C-w>< <C-w><<SID>ws
nnoremap <script> <SID>ws+ <C-w>+<SID>ws
nnoremap <script> <SID>ws- <C-w>-<SID>ws
nnoremap <script> <SID>ws> <C-w>><SID>ws
nnoremap <script> <SID>ws< <C-w><<SID>ws
nnoremap <script> <SID>wsq <Nop>
nmap <SID>ws <Nop>

" 検索ハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" grep プログラム設定
if executable('jvgrep')
  set grepprg=jvgrep
endif
" grep を silent で実行する Grep コマンドを定義
command! -nargs=+ Grep execute 'silent grep! <args>'

" 非表示文字の設定
set list
set listchars=tab:\ \ ,trail:-,nbsp:%

" モード変更時にカーソルを変更する設定
if &term =~ 'xterm\|screen'
  let &t_ti .= "\e[1 q" " termcap mode に入った時
  let &t_SI .= "\e[5 q" " insert mode に入った時
  let &t_EI .= "\e[1 q" " insert mode を抜けた時
  let &t_te .= "\e[0 q" " termcap mode を抜けた時
endif

" マウス
if has('mouse')
  set mouse=nv
endif

" フォントの設定
if has("gui_running")
  set guifont=Cica:h14:cSHIFTJIS:qDRAFT
endif

" カラー表示可能かどうかチェック
if &t_Co > 2 || has("gui_running")
  " シンタックスハイライトを on
  syntax on
  " 検索時のハイライト表示を on
  set hlsearch

  " Gruvbox の設定
  let g:gruvbox_transparent_bg = 1 " この設定は現在機能していないっぽい
  let g:gruvbox_contrast_dark = "midium"

  if has("win32")
    " True Color 有効化
    set termguicolors
    " カラーテーマ設定
    colorscheme gruvbox
    " ダークテーマに設定
    set background=dark
  else
    " True Color をサポートしている場合
    if $COLORTERM =~? 'truecolor\|24bit'
      " True Color 有効化
      set termguicolors
    endif

    " 256色以上の場合
    if &t_Co >= 256 || has("gui_running")
      " カラーテーマ設定
      colorscheme gruvbox
      " ダークテーマに設定
      set background=dark
    endif
  endif

  if &termguicolors
    " デフォルトの設定だと色が見えないのでコントラストを上げる
    hi! link NonText GruvboxBg4
    hi! link SpecialKey GruvboxBg3

    " 背景を透過する
    hi Normal guibg=NONE
  else
    " 背景を透過する
    hi Normal ctermbg=NONE
  endif

  " lightline.vim
  let g:lightline = {
    \ 'active':{
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'charinfo', 'fileformat', 'fileencoding', 'filetype', 'lsperror', 'lspwarning' ] ]
    \ },
    \ 'component': {
    \   'charinfo': 'U+%04B',
    \   'lineinfo': '%3l:%-2v'
    \ },
    \ 'component_function': {
    \   'filetype': 'LightLineFiletype',
    \   'fileformat': 'LightLineFileformat'
    \ },
    \ 'component_expand': {
    \   'lsperror': 'LightlineLspErrorCount',
    \   'lspwarning': 'LightlineLspWarningCount'
    \ },
    \ 'component_type': {
    \   'lsperror': 'error',
    \   'lspwarning': 'warning'
    \ },
    \ 'colorscheme': 'gruvbox'
    \ }
  function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endfunction
  function! LightLineFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endfunction

  function LightlineLspErrorCount()
    if !exists('*lsp#get_buffer_diagnostics_counts')
      return ''
    endif

    let l:counts = lsp#get_buffer_diagnostics_counts()

    if l:counts['error'] > 0
      return printf('E:%d', l:counts['error'])
    else
      return ''
    endif
  endfunction

  function LightlineLspWarningCount()
    if !exists('*lsp#get_buffer_diagnostics_counts')
      return ''
    endif

    let l:counts = lsp#get_buffer_diagnostics_counts()

    if l:counts['warning'] > 0
      return printf('W:%d', l:counts['warning'])
    else
      return ''
    endif
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

  " バッファーが閉じられたとき Quickfix が最後のバッファーのとき
  " Quickfix を自動で閉じる
  augroup QuickFixAutoClose
    autocmd BufEnter * if (winnr("$") == 1 && &buftype == "quickfix") | q | endif
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

  " File types
  augroup MyFileTypes
    autocmd!
    autocmd BufNewFile,BufRead *.metal	setf metal
  augroup END

else

  " autoindent を設定
  set autoindent

endif " has("autocmd")

if has('quickfix')
  set previewheight=6

  nnoremap <silent> <C-n>     :cnext<CR>
  nnoremap <silent> <C-p>     :cprevious<CR>
  nnoremap <silent> <leader>q :cclose<CR>
endif

if has('langmap') && exists('+langnoremap')
  " langmap の文字がマッピングの結果として適用されないようにする
  " (このオプションは後方互換性のためデフォルトはOFF)
  set langnoremap
endif

" load vimrc.d/*.vim
runtime! vimrc.d/*.vim

