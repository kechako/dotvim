vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['dart', 'language-server']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'dart',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['pubspec.yaml', '.git/']),
    'initialization_options': {
    },
    'allowlist': ['dart'],
  }
enddef
