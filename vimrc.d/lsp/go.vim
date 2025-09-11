vim9script

import "./utils.vim"

export def Format()
  call execute('LspCodeActionSync source.organizeImports')
  call execute('LspDocumentFormatSync')
enddef

def ServerCmd(server_info: dict<any>): list<string>
  final cmd = ['gopls', 'serve']
  if !executable(cmd[0])
    return []
  endif

  return cmd
enddef

export def ServerInfo(): dict<any>
  return {
    'name': 'golang',
    'cmd': ServerCmd,
    'root_uri': (server_info) => utils.FindRootURI(['go.mod', '.git/']),
    'initialization_options': {
      # Build
      'buildFlags': [],
      'env': {},
      'directoryFilters': ['-**/node_modules'],
      'templateExtensions': [],
      'expandWorkspaceToModule': true,
      'standaloneTags': ['ignore'],

      # Formatting
      'local': '',
      'gofumpt': false,

      # UI
      'codelenses': {
        'gc_details': false,
        'generate': true,
        'regenerate_cgo': true,
        'run_govulncheck': true,
        'test': true,
        'tidy': true,
        'upgrade_dependency': true,
        'vendor': false,
      },
      'semanticTokens': false,
      'noSemanticString': false,
      'noSemanticNumber': false,

      # Completion
      'usePlaceholders': true,
      'completionBudget': '100ms',
      'matcher': 'Fuzzy',
      'experimentalPostfixCompletions': true,

      # Diagnostic
      'analyses': {},
      'staticcheck': true,
      'annotations': {
        'bounds': true,
        'escape': true,
        'inline': true,
        'nil': true,
      },
      'vulncheck': 'Imports',
      'diagnosticsDelay': '400ms',

      # Documentation
      'hoverKind': 'FullDocumentation',
      'linkTarget': 'pkg.go.dev',
      'linksInHover': true,

      # Inlayhint
      'hints': {
        'assignVariableTypes': true,
        'constantValues': true,
        'functionTypeParameters': true,
        'rangeVariableTypes': true,
      },

      # Navigation
      'importShortcut': 'Both',
      'symbolMatcher': 'FastFuzzy',
      'symbolStyle': 'Dynamic',
      'symbolScope': 'all',
      'verboseOutput': false,
    },
    'allowlist': ['go', 'gomod', 'gowork', 'template'],
  }
enddef
