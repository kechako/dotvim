vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['omnisharp', '-s', FindCSharpProjectFile(), '-lsp']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

def FindCSharpProjectFile(): string
  var projfile = utils.FindFileUpwards(['*.sln', '*.csproj'], fnamemodify(utils.GetBufferPath(), ':p:h'))

  if empty(projfile)
    return utils.GetBufferPath()
  endif

  return projfile
enddef

def FindCSharpProjectRootURI(): string
  return utils.PathToURI(fnamemodify(FindCSharpProjectFile(), ':p:h'))
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'csharp',
    'cmd': ServerCmd,
    'root_uri': (server_info) => FindCSharpProjectRootURI(),
    'allowlist': [
      'cs',
    ],
  }
enddef
