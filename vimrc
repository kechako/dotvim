" vi 互換モードをOFFに
if &compatible
  set nocompatible
endif

"dein Scripts-----------------------------
" Required:
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('~/.vim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('altercation/vim-colors-solarized')
call dein#add('itchyny/lightline.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('fatih/vim-go')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts--------------------

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
" 入力中のコマンドを表示
set showcmd
" インクリメタルサーチを実行
set incsearch
" ステータス行の表示
set laststatus=2
" 補完の一覧表示
set wildmenu
set wildmode=list:full

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

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif
