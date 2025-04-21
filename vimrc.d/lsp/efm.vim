vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['efm-langserver']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

def WorkspaceConfig(server_info: dict<any>): dict<any>
  echom &filetype
  if &filetype == 'python'
    return {
      'languages': {
        'python': [
          {
            'formatCommand': 'black --quiet -',
            'formatStdin': true,
          },
        ],
      },
    }
  endif

  return {}
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'efm-langserver',
    'cmd': ServerCmd,
    'initialization_options': {
      'documentFormatting': true,
    },
    'workspace_config': WorkspaceConfig,
    'whitelist': ['python'],
  }
enddef
