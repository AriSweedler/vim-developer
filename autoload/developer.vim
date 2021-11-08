"
" Author: Ari Sweedler
"

" Accepts 2 maps:
" * actions - from 'key' to 'ex command'
" * files ' from 'key' to 'filepath'
function! developer#KeymappingForActionsOnFiles(actions, files)
  for [key_a, action] in items(a:actions)
    for [key_f, file] in items(a:files)
      let key_dev = "<Leader>"
      let keymap = key_dev.key_a.key_f
      let ex_cmd = ":".action." ".file
      execute "nnoremap <silent> ".keymap." ".ex_cmd."<CR>"
    endfor
  endfor
endfunction

" Call this in a plugin's ftplugin file to be able to do this
" Like so:
"
"     call developer#RegisterPlugin('<sfile>:h:h')
"
function! developer#RegisterPlugin(plug_root, ...)
  let s:actions = #{
  \   s: 'source',
  \   e: 'tabedit',
  \   ee: 'edit',
  \ }
  let s:submodule = (a:0 > 0) ? a:1 : '<C-r>=&filetype<CR>'
  let s:files = #{
  \   pa: a:plug_root.'/autoload/'.s:submodule.'.vim',
  \   pp: a:plug_root.'/ftplugin/'.s:submodule.'.vim',
  \   pf: a:plug_root.'/ftplugin/<C-r>=&filetype<CR>.vim',
  \   ps: a:plug_root.'/syntax/<C-r>=&filetype<CR>.vim',
  \ }
  call developer#KeymappingForActionsOnFiles(s:actions, s:files)
endfunction

