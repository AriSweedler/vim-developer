" Give access to the Developer command.
" Edit or source the relvant files in just a few keystrokes

" Developer command ::= <Leader><action><file>
" Leader ::= <Leader>
" action ::=
"   s (source)
" | e (tabedit)
" file ::=
"   v (vimrc)
" | o (current file)
" | f (ftplugin)
" | s (syntax)
" | F (system ftplugin)
" | S (system syntax)
" | p (relevant plugin 1 - set this mapping in <Leader>ef)
" | P (relevant plugin 2 - set this mapping in <Leader>ef)

let s:actions = #{
\   s: 'source',
\   e: 'tabedit',
\ }
let s:files = #{
\   v: '$MYVIMRC',
\   o: '%',
\   f: '$HOME/.vim/after/ftplugin/<C-r>=&filetype<CR>.vim',
\   s: '$HOME/.vim/after/syntax/<C-r>=&filetype<CR>.vim',
\   F: '$VIMRUNTIME/ftplugin/<C-r>=&filetype<CR>.vim',
\   S: '$VIMRUNTIME/syntax/<C-r>=&filetype<CR>.vim',
\ }

for [key_a, action] in items(s:actions)
  for [key_f, file] in items(s:files)
    let key_dev = "<Leader>"
    let keymap = key_dev.key_a.key_f
    let ex_cmd = ":".action." ".file
    execute "nnoremap <silent> ".keymap." ".ex_cmd."<CR>"
  endfor
endfor
nnoremap <silent> <Leader>ep :echom "WARN: If you want to use '\<Leader>ep{s,f}' then have a plugin register itself with 'call developer#RegisterPlugin(...)"<CR>
