vim9script

g:fern#default_exclude = '\.meta$'
g:fern#renderer = 'nerdfont'

def FernSetup()
  nnoremap <buffer> <nowait> <silent> q :<c-u>quit<cr>
  nmap <buffer>
        \ <Plug>(fern-action-open)
        \ <Plug>(fern-action-open:select)
  # 行番号の表示桁数を2桁にする
  setlocal numberwidth=2
  # 目印の表示を消す
  setlocal signcolumn=no
  # 折り畳みの表示を消す
  setlocal foldcolumn=0
  # ウィンドウにバッファーを固定する
  setlocal winfixbuf
enddef

def CanOpenFern(): bool
  if argc() == 1 && argv(0) == ".git/COMMIT_EDITMSG"
    return false
  endif

  if argc() == 1 && argv(0) == ".git/rebase-merge/git-rebase-todo"
    return false
  endif

  if exists("s:std_in")
    return false
  endif

  return true
enddef

def FindNearestParentDirectory(path: string, directoryname: string): string
  var relative_path = finddir(directoryname, fnameescape(path) .. ';')

  if !empty(relative_path)
    return fnamemodify(relative_path, ':p')
  else
    return ''
  endif
enddef

def FindNearestParentFile(path: string, filename: string): string
  var relative_path = findfile(filename, fnameescape(path) .. ';')

  if !empty(relative_path)
    return fnamemodify(relative_path, ':p')
  else
    return ''
  endif
enddef

def FindNearestParentFileDirectory(path: string, filename: string): string
  var modify_str = ''
  var found_path = ''
  if filename[-1 : ] ==# '/' || filename[-1 : ] ==# '\'
    modify_str = ':p:h:h'
    found_path = FindNearestParentDirectory(path, filename[ : -1])
  else
    modify_str = ':p:h'
    found_path = FindNearestParentFile(path, filename)
  endif

  return empty(found_path) ? '' : fnamemodify(found_path, modify_str)
enddef

def FindGitRoot(): string
  var path = FindNearestParentFileDirectory(expand('%:p'), '.git')
  if !empty(path)
    return path
  endif

  path = FindNearestParentFileDirectory(expand('%:p'), '.git/')
  if !empty(path)
    return path
  endif

  return "."
enddef

def OpenFern(toggle: bool, path: string = ""): void
  var url = path
  if url == ""
    url = FindGitRoot()
  endif
  var reveal = expand('%:p')
  if empty(reveal)
    reveal = getcwd()
  endif
  if toggle
    execute 'Fern' url '-drawer' '-stay' '-toggle' '-reveal=' .. reveal
  else
    execute 'Fern' url '-drawer' '-stay' '-reveal=' .. reveal
  endif
enddef

def FernVimEnter(toggle: bool)
  if CanOpenFern()
    OpenFern(toggle)
  endif
enddef

augroup __fern__
  autocmd!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * ++nested call FernVimEnter(false)
  autocmd FileType fern call FernSetup()
augroup END

command! ToggleFern call OpenFern(true)

nnoremap <silent> <leader>o :ToggleFern<CR>
#nnoremap <silent> <leader>o call OpenFern()
#nnoremap <silent> <leader>o :<c-u>Fern . -drawer -stay -toggle -reveal=%<cr>
