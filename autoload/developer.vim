"
" Author: Ari Sweedler
"

" Accepts 2 maps:
" * actions - from 'key' to 'ex command'
" * files ' from 'key' to 'filepath'
function! s:KeymappingForActionsOnFiles(actions, files)
  for [key_a, action] in items(a:actions)
    for [key_f, file] in items(a:files)
      let key_dev = "<Leader>"
      let keymap = key_dev.key_a.key_f
      let ex_cmd = ":".action." ".file
      execute "nnoremap <silent> ".keymap." ".ex_cmd."<CR>"
    endfor
  endfor
endfunction

let s:actions = #{
\   s: 'source',
\   e: 'tabedit',
\   E: 'edit!',
\ }
let s:files = #{
\   v: '$MYVIMRC',
\   o: '%',
\   f: '$HOME/.vim/after/ftplugin/<C-r>=&filetype<CR>.vim',
\   s: '$HOME/.vim/after/syntax/<C-r>=&filetype<CR>.vim',
\   F: '$VIMRUNTIME/ftplugin/<C-r>=&filetype<CR>.vim',
\   S: '$VIMRUNTIME/syntax/<C-r>=&filetype<CR>.vim',
\ }
function! developer#init()
  call <SID>KeymappingForActionsOnFiles(s:actions, s:files)
endfunction

" Call this in a plugin's ftplugin file to be able to do this
" Like so:
"
"     call developer#register_plugin('<sfile>:h:h')
"
function! developer#register_plugin(plug_root, ...)
  let s:submodule = (a:0 > 0) ? a:1 : '<C-r>=&filetype<CR>'
  let s:plug_files = #{
  \   pa: a:plug_root.'/autoload/'.s:submodule.'.vim',
  \   pp: a:plug_root.'/plugin/'.s:submodule.'.vim',
  \   pf: a:plug_root.'/ftplugin/<C-r>=&filetype<CR>.vim',
  \   ps: a:plug_root.'/syntax/<C-r>=&filetype<CR>.vim',
  \ }
  call <SID>KeymappingForActionsOnFiles(s:actions, s:plug_files)
endfunction
