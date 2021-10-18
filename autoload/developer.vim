" Call this in a plugin's ftplugin file to be able to do this
" TODO breaks the pattern but what can u say
function! developer#RegisterPlugin(plug_root)
  execute "nnoremap <silent> <buffer> <Leader>eps :tabedit ".a:plug_root."/syntax/log.vim<CR>"
  execute "nnoremap <silent> <buffer> <Leader>epf :tabedit ".a:plug_root."/ftplugin/log.vim<CR>"
endfunction
