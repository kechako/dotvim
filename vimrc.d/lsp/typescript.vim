vim9script

import "./utils.vim"

def ServerCmd(server_info: dict<any>): list<string>
  var root_path = utils.FindRootPath(['deno.json', 'tsconfig.json', 'package.json', '.git/'])

  var is_deno = false
  if filereadable(root_path .. "/deno.json")
    is_deno = true
  endif
  server_info.root_path = root_path
  server_info.is_deno = is_deno

  var cmd = []
  if is_deno
    cmd = ['deno', 'lsp']
  else
    cmd = ['typescript-language-server', '--stdio']
  endif
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

def TypeScriptRootURI(server_info: dict<any>): string
  return utils.PathToURI(server_info.root_path)
enddef

def TypeScriptWorkspaceConfig(server_info: dict<any>): dict<any>
  if server_info.is_deno
    return {
      'deno': {
        'enable': true,
        'lint': true,
        'unstable': true,
        'codeLens': {
          'implementations': true,
          'references': true,
          'referencesAllFunctions': true,
          'test': true,
        },
        'suggest': {
          'imports': {
            'autoDiscover': false,
            'hosts': {
              'https://deno.land/': true,
            },
          },
        },
      },
      'javascript': {
        'inlayHints': {
          'parameterNames': {
            'enabled': 'all',
            'suppressWhenArgumentMatchesName': true,
          },
          'parameterTypes': {
            'enabled': true,
          },
          'variableTypes': {
            'enabled': true,
            'suppressWhenTypeMatchesName': true,
          },
          'propertyDeclarationTypes': {
            'enabled': true,
          },
          'functionLikeReturnTypes': {
            'enabled': true,
          },
          'enumMemberValues': {
            'enabled': true,
          },
        },
        'suggest': {
          'enabled': true,
          'completeFunctionCalls': true,
          'includeAutomaticOptionalChainCompletions': true,
          'includeCompletionsForImportStatements': true,
          'names': true,
          'paths': true,
          'autoImports': true,
        },
      },
      'typescript': {
        'inlayHints': {
          'parameterNames': {
            'enabled': 'all',
            'suppressWhenArgumentMatchesName': true,
          },
          'parameterTypes': {
            'enabled': true,
          },
          'variableTypes': {
            'enabled': true,
            'suppressWhenTypeMatchesName': true,
          },
          'propertyDeclarationTypes': {
            'enabled': true,
          },
          'functionLikeReturnTypes': {
            'enabled': true,
          },
          'enumMemberValues': {
            'enabled': true,
          },
        },
        'suggest': {
          'enabled': true,
          'completeFunctionCalls': true,
          'includeAutomaticOptionalChainCompletions': true,
          'includeCompletionsForImportStatements': true,
          'names': true,
          'paths': true,
          'autoImports': true,
        },
      },
    }
  else
    return {}
  endif
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'typescript',
    'cmd': ServerCmd,
    'root_uri': TypeScriptRootURI,
    'workspace_config': TypeScriptWorkspaceConfig,
    'whitelist': [
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    ],
  }
enddef
