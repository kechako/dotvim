vim9script

def UseMise(cmd: string): bool
  if !executable('mise')
    return false
  endif

  system($'mise which {shellescape(cmd)} > /dev/null 2>&1')
  return v:shell_error == 0
enddef

if UseMise("clang-format")
  g:clang_format#command = "mise exec -- clang-format"
endif

g:clang_format#auto_format = 1
g:clang_format#auto_filetypes = ["c", "cpp", "arduino"]
