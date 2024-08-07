vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['terraform-ls', 'serve']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'terraform',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['.git/']),
    'initialization_options': {},
    'whitelist': ['terraform', 'tf'],
  }
enddef
