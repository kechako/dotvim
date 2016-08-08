" vi 互換モードをOFFに
if &compatible
  set nocompatible
endif

" insert mode でバックスペースで削除可能な文字の設定
set backspace=indent,eol,start
" 行番号表示
set number
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
" netrwhist の場所
let g:netrw_home=expand("$HOME/.vim")

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
    \ 'colorscheme': 'solarized'
    \ }
endif

" クリップボードが有効な場合
if has("clipboard")
  " Yank と Clipboard を連携
  set clipboard=unnamed
endif

" autocmd が有効な場合
if has("autocmd")
  " ファイルタイプの検出を有効にする
  " ファイルタイププラグインを使用する
  " インデントファイルを使う
  filetype plugin indent on

  " autocmd group を設定
  augroup vimrcEx
  au!

  " すべてのテキストファイルで78文字で折り返す
  autocmd FileType text setlocal textwidth=78

  " ファイルを開いた時に、前回のカーソル位置に移動する
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  " autoindent を設定
  set autoindent

endif " has("autocmd")

if has('langmap') && exists('+langnoremap')
  " langmap の文字がマッピングの結果として適用されないようにする
  " (このオプションは後方互換性のためデフォルトはOFF)
  set langnoremap
endif
