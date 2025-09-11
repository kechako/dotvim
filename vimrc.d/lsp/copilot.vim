vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['copilot-language-server', '--stdio']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'copilot',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['.git/']),
    'initialization_options': {
      'editorInfo': {
        'name': 'GNU ed',
        'version': '1.19',
      },
      'editorPluginInfo': {
        'name': 'GitHub Copilot for ed',
        'version': '1.0.0'
      },
    },
    'workspace_config': {},
    'allowlist': ['*'],
  }
enddef

export def OnLspBufferEnabled(): void
  command! -buffer -nargs=0 CopilotSignIn call lsp#send_request('copilot', {
    'method': 'signIn',
    'params': {},
    'sync': v:false,
    'on_notification': CopilotHandleSignin,
  })
  command! -buffer -nargs=0 CopilotSignOut call lsp#send_request('copilot', {
    'method': 'signOut',
    'params': {},
    'sync': v:false,
    'on_notification': CopilotHandleSignout,
  })
enddef

def CopilotHandleFinish(data: dict<any>): void
  final response = data['response']
  if response->has_key('error')
    echoerr response['error']['message']
    return
  endif

  final result = response['result']
  final status = result['status']
  if status == 'OK'
    echomsg 'Sign-in completed.'
  else
    echomsg result['status']
  endif
enddef

def CopilotHandleSignin(data: dict<any>): void
  final response = data['response']
  if response->has_key('error')
    echoerr response['error']['message']
    return
  endif

  final result = response['result']
  final status = result['status']
  if status == 'PromptUserDeviceFlow'
    final userCode = result['userCode']
    final command = result['command']
    @+ = userCode
    echomsg printf("Your code has been copied to the clipboard: %s", userCode)

    call lsp#send_request('copilot', {
      'method': 'workspace/executeCommand',
      'params': command,
      'sync': v:false,
      'on_notification': CopilotHandleFinish,
    })
  elseif status == 'AlreadySignedIn'
    final user = result['user']
    echomsg printf("You are already signed in: %s", user)
  else
    echomsg status
  endif
enddef

def CopilotHandleSignout(data: dict<any>): void
  final response = data['response']
  if response->has_key('error')
    echoerr response['error']['message']
    return
  endif

  final result = response['result']
  final status = result['status']
  if status == 'NotSignedIn'
    echomsg 'Signed out.'
  else
    echomsg result['status']
  endif
enddef
