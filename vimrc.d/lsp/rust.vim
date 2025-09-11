vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['rustup', 'run', 'stable', 'rust-analyzer']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'Rust Language Server',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['Cargo.toml', '.git/']),
    'initialization_options': {
      'cargo': {
        'buildScripts': {
          'enable': true,
        },
      },
      'procMacro': {
        'enable': true,
      },
    },
    'allowlist': ['rust'],
  }
enddef
