vim9script

def GenerateUUID(count: number = 1): string
  var cmd = 'uuidgen -7'
  if count > 1
    cmd = cmd .. ' -c ' .. count
  else
    cmd = cmd .. ' -n'
  endif

  return system(cmd)
enddef

def InsertUUID(count: number = 1)
  final text = GenerateUUID(count)

  if mode() =~# '^[iR]'
    feedkeys(text, 'in')
  else
    execute 'normal! a' .. text
  endif
enddef

nnoremap <silent> <Leader>u <ScriptCmd>InsertUUID(v:count1)<CR>
inoremap <silent> <C-g>u <ScriptCmd>InsertUUID(1)<CR>

command! -nargs=? UUIDGen InsertUUID(<q-args> == '' ? 1 : str2nr(<q-args>))
