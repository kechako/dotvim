vim9script

import "./utils.vim"

final sourcekit_lsp_args = [
  '-Xswiftc',
  '-sdk',
  '-Xswiftc',
  '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk',
  '-Xswiftc',
  '-target',
  '-Xswiftc',
  'x86_64-apple-ios14.0-simulator',
]

def ServerCmd(server_info: dict<any>): list<string>
  if executable('xcrun')
    silent call system('xcrun --find sourcekit-lsp')
    if v:shell_error == 0
      return ['xcrun', '--toolchain', 'swift', 'sourcekit-lsp']
      #return ['xcrun', 'sourcekit-lsp'] + sourcekit_lsp_args,
    endif
  endif

  if executable('sourcekit-lsp')
    return ['sourcekit-lsp']
    #return ['sourcekit-lsp'] + sourcekit_lsp_args,
  endif

  return []
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'swift',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['Pacakge.swift']),
    'allowlist': ['swift', 'metal', 'objective-c', 'objective-cpp'],
  }
enddef
