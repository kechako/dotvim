" vim:set fenc=utf-8 ff=unix

" encoding
set encoding=utf-8

" insert mode でバックスペースで削除可能な文字の設定
set backspace=indent,eol,start

" vimfiles
let s:vimfilesdir = $HOME . '/.vim'
if has("win32")
  " for windows
  let s:vimfilesdir = $HOME . '/vimfiles'
endif
" スワップファイルを作成
set swapfile
let &directory = s:vimfilesdir . '/swap'
" バックアップファイルを作成
set backup
let &backupdir = s:vimfilesdir . '/backup'
" undo ファイルを作成
set undofile
let &undodir = s:vimfilesdir . '/undo'

" コマンドライン履歴を50行保存
set history=50
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
set wildmode=list:full
" 曖昧な幅の文字を double width で表示
set ambiwidth=double
" netrw にてファイル名、サイズ、タイムスタンプをデフォルト表示
let g:netrw_liststyle=1
" .netrwhist 及び .netrwbook の格納場所
let g:netrw_home=expand("$HOME/.vim/netrw")
" コマンドラインの高さ
set cmdheight=4
" 行版行
set number
set numberwidth=6
" ビープを鳴らさない
set vb t_vb=
" leader に ',' を設定
let mapleader = ","

" <C-p>, <C-n> による履歴の参照の動作を <Up>, <Down> に合わせる
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

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
  set mouse=a
endif

" signs
if has('signs')
  " 目印行を常に表示する
  set signcolumn=yes
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

  if has("win32")
    " True Color 有効化
    set termguicolors
    " カラーテーマ設定
    colorscheme iceberg
  else
    " True Color をサポートしている場合
    if $COLORTERM =~? 'truecolor\|24bit'
      " True Color 有効化
      set termguicolors
      if $VTE_VERSION == ""
        let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
        let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
      endif
    endif

    " 256色以上の場合
    if &t_Co >= 256 || has("gui_running")
      " カラーテーマ設定
      colorscheme iceberg
    endif
  endif

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
    \ 'colorscheme': 'iceberg'
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
  set previewheight=6

  map <C-j> :cnext<CR>
  map <C-k> :cprevious<CR>
  nnoremap <leader>q :cclose<CR>
endif

if has('langmap') && exists('+langnoremap')
  " langmap の文字がマッピングの結果として適用されないようにする
  " (このオプションは後方互換性のためデフォルトはOFF)
  set langnoremap
endif

" load vimrc.d/*.vim
runtime! vimrc.d/*.vim

