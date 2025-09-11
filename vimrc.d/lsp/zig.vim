vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['zls']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'zls',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['.git/']),
    'initialization_options': {},
    'allowlist': ['zig'],
  }
enddef
