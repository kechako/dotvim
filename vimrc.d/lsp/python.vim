vim9script

import "./utils.vim"

def GetRootPath(): string
  return utils.FindRootPath(['pyproject.toml', 'pyrightconfig.json', 'requirements.txt', '.git/'])
enddef

def ServerCmd(server_info: dict<any>): list<string>
  var cmd = ['pyright-langserver', '--stdio']
  if !executable(cmd[0])
    return []
  endif

  final root_path = GetRootPath()
  if filereadable(root_path .. "/pyproject.toml") && executable('hatch')
    cmd = ['hatch', 'run'] + cmd
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'pyright',
    'cmd': ServerCmd,
    'root_uri': (server_info) => GetRootPath(),
    'initialization_options': {
    },
    'whitelist': ['python'],
  }
enddef
