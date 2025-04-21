vim9script

import "./lsp/utils.vim"
import "./lsp/cs.vim"
import "./lsp/dart.vim"
import "./lsp/efm.vim"
import "./lsp/go.vim"
import "./lsp/python.vim"
import "./lsp/rust.vim"
import "./lsp/swift.vim"
import "./lsp/terraform.vim"
import "./lsp/typescript.vim"
import "./lsp/zig.vim"

# vim-lsp
g:lsp_text_edit_enabled = 0
g:lsp_async_completion = 1
g:lsp_diagnostics_echo_cursor = 1
g:lsp_diagnostics_float_cursor = 1
g:lsp_diagnostics_signs_enabled = 1
g:lsp_diagnostics_signs_error = {'text': '✗'}
g:lsp_diagnostics_signs_warning = {'text': '‼'}
g:lsp_diagnostics_signs_information = {'text': 'ii'}
g:lsp_diagnostics_signs_hint = {'text': '??'}

g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
g:lsp_diagnostics_virtual_text_prefix = "》"
g:lsp_diagnostics_virtual_text_align = "right"

g:lsp_inlay_hints_enabled = 1
g:lsp_inlay_hints_mode = {
  'normal': ['curline'],
}

# hightlight references
highlight lspReference ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478

g:lsp_preview_keep_focus = 1

def OnLspBufferEnabled()
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

  g:lsp_format_sync_timeout = 1000
  autocmd! BufWritePre *.go call go.Format()
  autocmd! BufWritePre *.cs,go.mod,go.work,*.tmpl,*.js,*.mjs,*.jsx,*.ts,*.mts,*.tsx,*.py,*.rs,*.swift,*.zig,*.dart,*.tf call execute('LspDocumentFormatSync')
enddef

# Go
autocmd User lsp_setup call lsp#register_server(go.ServerInfo())
# Rust
autocmd User lsp_setup call lsp#register_server(rust.ServerInfo())
# Zig
autocmd User lsp_setup call lsp#register_server(zig.ServerInfo())
# Dart
autocmd User lsp_setup call lsp#register_server(dart.ServerInfo())
# TypeScript
autocmd User lsp_setup call lsp#register_server(typescript.ServerInfo())
# C#
autocmd User lsp_setup call lsp#register_server(cs.ServerInfo())
# swift
autocmd User lsp_setup call lsp#register_server(swift.ServerInfo())
# Terraform
autocmd User lsp_setup call lsp#register_server(terraform.ServerInfo())
# Python
autocmd User lsp_setup call lsp#register_server(python.ServerInfo())
# efm
autocmd User lsp_setup call lsp#register_server(efm.ServerInfo())

augroup LspInstall
  autocmd!
  autocmd User lsp_buffer_enabled call OnLspBufferEnabled()
augroup END

def OnLspDiagnosticsUpdatedForLightline()
  if exists('*lightline#update')
    call lightline#update()
  endif
enddef

augroup LspForLightline
  autocmd!
  autocmd User lsp_diagnostics_updated call OnLspDiagnosticsUpdatedForLightline()
augroup END
