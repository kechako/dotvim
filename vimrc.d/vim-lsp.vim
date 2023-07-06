" vim-lsp
let g:lsp_text_edit_enabled = 0
let g:lsp_async_completion = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '‼'}
let g:lsp_diagnostics_signs_information = {'text': 'ii'}
let g:lsp_diagnostics_signs_hint = {'text': '??'}

let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
let g:lsp_diagnostics_virtual_text_prefix = "》"
let g:lsp_diagnostics_virtual_text_align = "right"

" hightlight references
highlight lspReference ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478

let g:lsp_preview_keep_focus = 1

function s:find_root_uri(filename)
  return lsp#utils#path_to_uri(
        \   lsp#utils#find_nearest_parent_file_directory(
        \     lsp#utils#get_buffer_path(),
        \     a:filename
        \   )
        \)
endfunction

function s:on_lsp_buffer_enabled()
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  nmap <buffer><silent> gd         <plug>(lsp-definition)
  nmap <buffer><silent> <C-]>      <plug>(lsp-definition)

  nmap <buffer><silent> ga         <plug>(lsp-code-action)
  nmap <buffer><silent> gr         <plug>(lsp-references)
  nmap <buffer><silent> gi         <plug>(lsp-implementation)
  nmap <buffer><silent> gt         <plug>(lsp-type-definition)
  nmap <buffer><silent> K          <plug>(lsp-hover)
  nmap <buffer><silent> gp         <plug>(lsp-previous-diagnostic)
  nmap <buffer><silent> gn         <plug>(lsp-next-diagnostic)
  nmap <buffer><silent> gD         <plug>(lsp-document-diagnostics)

  nmap <buffer><silent> <leader>rn <plug>(lsp-rename)
  nmap <buffer><silent> <leader>ds <plug>(lsp-document-symbol)
  nmap <buffer><silent> <leader>ws <plug>(lsp-workspace-symbol)
  nmap <buffer><silent> <leader>m  :make<CR>
  nmap <buffer><silent> <leader>t  :make test<CR>

  let g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.go call s:goFormat()
  autocmd! BufWritePre *.cs,go.mod,go.work,*.tmpl,*.js,*.jsx,*.ts,*.tsx,*.py,*.rs,*.swift,*.zig call execute('LspDocumentFormatSync')
endfunction

function s:goFormat()
  call execute('LspCodeActionSync source.organizeImports')
  call execute('LspDocumentFormatSync')
endfunction

" Go
if executable('gopls')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'golang',
        \ 'cmd': {server_info->['gopls', 'serve']},
        \ 'root_uri': {server_info->s:find_root_uri(['go.mod', '.git/'])},
        \ 'initialization_options': {
        \   '** Build **': '',
        \   'buildFlags': [],
        \   'env': {},
        \   'directoryFilters': ['-**/node_modules'],
        \   'templateExtensions': [],
        \   'memoryMode': 'Normal',
        \   'expandWorkspaceToModule': v:true,
        \   'allowModfileModifications': v:false,
        \   'allowImplicitNetworkAccess': v:false,
        \   'standaloneTags': ['ignore'],
        \
        \   '** Formatting **': '',
        \   'local': '',
        \   'gofumpt': v:false,
        \
        \   '** UI **': '',
        \   'codelenses': {
        \     'gc_details': v:false,
        \     'generate': v:true,
        \     'regenerate_cgo': v:true,
        \     'run_govulncheck': v:true,
        \     'test': v:true,
        \     'tidy': v:true,
        \     'upgrade_dependency': v:true,
        \     'vendor': v:false,
        \   },
        \   'SemanticTokens': v:false,
        \   'noSemanticString': v:false,
        \   'noSemanticNumber': v:false,
        \
        \   '*** Completion ***': '',
        \   'usePlaceholders': v:true,
        \   'completionBudget': '100ms',
        \   'matcher': 'Fuzzy',
        \   'experimentalPostfixCompletions': v:true,
        \
        \   '*** Diagnostic ***': '',
        \   'analyses': {},
        \   'staticcheck': v:true,
        \   'annotations': {
        \     'bounds': v:true,
        \     'escape': v:true,
        \     'inline': v:true,
        \     'nil': v:true,
        \   },
        \   'vulncheck': 'Imports',
        \   'diagnosticsDelay': '400ms',
        \
        \   '*** Documentation ***': '',
        \   'hoverKind': 'FullDocumentation',
        \   'linkTarget': 'pkg.go.dev',
        \   'linksInHover': v:true,
        \
        \   '*** Inlayhint ***': '',
        \   'hints': {
        \     'assignVariableTypes': v:true,
        \     'constantValues': v:true,
        \     'functionTypeParameters': v:true,
        \     'rangeVariableTypes': v:true,
        \   },
        \
        \   '*** Navigation ***': '',
        \   'importShortcut': 'Both',
        \   'symbolMatcher': 'FastFuzzy',
        \   'symbolStyle': 'Dynamic',
        \   'symbolScope': 'all',
        \   'verboseOutput': v:false,
        \   'newDiff': 'both',
        \ },
        \ 'whitelist': ['go', 'gomod', 'gowork', 'template'],
        \ })
endif

" Rust
if executable('rustup')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'Rust Language Server',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rust-analyzer']},
        \ 'root_uri': {server_info->s:find_root_uri(['Cargo.toml', '.git/'])},
        \ 'initialization_options': {
        \   'cargo': {
        \     'buildScripts': {
        \       'enable': v:true,
        \     },
        \   },
        \   'procMacro': {
        \     'enable': v:true,
        \   },
        \ },
        \ 'whitelist': ['rust'],
        \ })
endif

" Zig
let s:zig_path = expand('~/zls/zls')
if executable(s:zig_path)
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'zls',
        \ 'cmd': {server_info->[s:zig_path]},
        \ 'root_uri': {server_info->s:find_root_uri(['.git/'])},
        \ 'initialization_options': {
        \ },
        \ 'whitelist': ['zig'],
        \ })
endif

" Python
if executable('pyls')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': ['pyls'],
        \ 'whitelist': ['python'],
        \ })
endif

" TypeScript
if executable('typescript-language-server')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'ts',
        \ 'cmd': ['typescript-language-server', '--stdio'],
        \ 'root_uri': {server_info->s:find_root_uri(['tsconfig.json', 'package.json', '.git/'])},
        \ 'initialization_options': {
        \   'diagnostics': v:true,
        \ },
        \ 'whitelist': [
        \   'javascript',
        \   'javascriptreact',
        \   'typescript',
        \   'typescriptreact',
        \   'typescript.tsx',
        \ ],
        \ })
endif

" C#
function s:find_file_upwards(exp, path) abort
  if type(a:exp) == 3
    for l:e in a:exp
      let l:files = glob(a:path . '/' . l:e, 0, 1)

      if empty(l:files)
        let l:parent = fnamemodify(a:path . '/../', ':p:h')
        if l:parent == a:path
          return ''
        endif
        return s:find_file_upwards(a:exp, l:parent)
      else
        return fnamemodify(l:files[0], ':p')
      endif
    endfor
  elseif type(a:exp) == 1
    let l:files = glob(a:path . '/' . a:exp, 0, 1)

    if empty(l:files)
      let l:parent = fnamemodify(a:path . '/../', ':p:h')
      if l:parent == a:path
        return ''
      endif
      return s:find_file_upwards(a:exp, l:parent)
    else
      return fnamemodify(l:files[0], ':p')
    endif
  else
    echoerr "The type of argument \"filename\" must be String or List"
  endif
endfunction

function s:find_csharp_project_file() abort
  let l:projfile = s:find_file_upwards(['*.sln', '*.csproj'], fnamemodify(lsp#utils#get_buffer_path(), ':p:h'))

  if empty(l:projfile)
    return lsp#utils#get_buffer_path()
  endif

  return l:projfile
endfunction

function s:find_csharp_project_root_uri() abort
  return lsp#utils#path_to_uri(fnamemodify(s:find_csharp_project_file(), ':p:h'))
endfunction

if executable('omnisharp')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'csharp',
        \ 'cmd': {server_info-> ['omnisharp', '-s', s:find_csharp_project_file(), '-lsp'] },
        \ 'root_uri': {server_info->s:find_csharp_project_root_uri()},
        \ 'whitelist': [
        \   'cs',
        \ ],
        \ })
endif

" swift
let s:swift_mode = 0 " 0: none, 1: sourcekit-lsp with xcrun, 2: sourcekit-lsp
if executable('xcrun')
  silent call system('xcrun --find sourcekit-lsp')
  if v:shell_error == 0
    let s:swift_mode = 1
  endif
endif
if s:swift_mode == 0 && executable('sourcekit-lsp')
  let s:swift_mode = 2
endif

let s:sourcekit_lsp_args = [
      \ '-Xswiftc',
      \ '-sdk',
      \ '-Xswiftc',
      \ '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk',
      \ '-Xswiftc',
      \ '-target',
      \ '-Xswiftc',
      \ 'x86_64-apple-ios14.0-simulator',
      \ ]

if s:swift_mode == 1
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'swift',
        \ 'cmd': ['xcrun', 'sourcekit-lsp'] + s:sourcekit_lsp_args,
        \ 'root_uri': {server_info->s:find_root_uri(['Pacakge.swift'])},
        \ 'whitelist': ['swift', 'metal', 'objective-c', 'objective-cpp'],
        \ })
elseif s:swift_mode == 2
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'swift',
        \ 'cmd': ['sourcekit-lsp'] + s:sourcekit_lsp_args,
        \ 'whitelist': ['swift', 'metal', 'objective-c', 'objective-cpp'],
        \ })
endif

" Elixir
if executable('elixir-ls')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'elixir',
        \ 'cmd': {server_info->['elixir-ls']},
        \ 'root_uri': {server_info->s:find_root_uri(['.git/'])},
        \ 'initialization_options': {},
        \ 'whitelist': ['elixir'],
        \ })
endif

augroup LspInstall
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

function s:on_lsp_diagnostics_updated_for_lightline()
  if exists('*lightline#update')
    call lightline#update()
  endif
endfunction

augroup LspForLightline
  autocmd!
  autocmd User lsp_diagnostics_updated call s:on_lsp_diagnostics_updated_for_lightline()
augroup END
