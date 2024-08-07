vim9script

export def PathToURI(path: string): string
  return lsp#utils#path_to_uri(path)
enddef

export def FindRootPath(filename: list<string>): string
  return lsp#utils#find_nearest_parent_file_directory(
    lsp#utils#get_buffer_path(),
    filename
  )
enddef

export def FindRootURI(filename: list<string>): string
  return PathToURI(FindRootPath(filename))
enddef

export def FindFileUpwards(exp: list<string>, path: string): string
  for e in exp
    var files = glob(path .. '/' .. e, 0, 1)

    if empty(files)
      var parent = fnamemodify(path .. '/../', ':p:h')
      if parent == path
        return ''
      endif
      return FindFileUpwards(exp, parent)
    else
      return fnamemodify(files[0], ':p')
    endif
  endfor

  return ''
enddef

export def GetBufferPath(): string
  return lsp#utils#get_buffer_path()
enddef
