" Give access to the Developer commands.
" Edit or source the relevant files in just a few keystrokes

" Developer command ::= <Leader><action><file>
"
" Leader ::= <Leader>
"
" action ::=
"   s (source)
" | S (split)
" | v (vertical split)
" | t (tabedit)
" | e (edit!)
"
" file ::=
"   ?            (help)
" | v            (vimrc)
" | o            (current file)
" | f            (ftplugin)
" | s            (syntax)
" | F            (system ftplugin)
" | S            (system syntax)
" | p<plug_file> (inside the registered plugin)
"
" plug_file ::=
"   a (autoload file named after the registered plugin)
" | p (pluginfile named after the registered plugin)
" | f (ftplugin for the current file's type)
" | s (syntax for the current file's type)

" Create the mappings
call developer#init()

" Can't take advantage of plugfiles unless
function s:error()
  echom "WARN: If you want to use '\<Leader>ep{s,f}' then have a plugin register itself with 'call developer#register_plugin(...)"
endfunction
nnoremap <silent> <Leader>sp :call <SID>error()<CR>
nnoremap <silent> <Leader>Sp :call <SID>error()<CR>
nnoremap <silent> <Leader>vp :call <SID>error()<CR>
nnoremap <silent> <Leader>tp :call <SID>error()<CR>
nnoremap <silent> <Leader>ep :call <SID>error()<CR>

" Generate the help mappings
" TODO use the grammar to write the help command somehow... Maybe with 'redir'
" or like just by naming stuff out. I dunno. The comment duplicates the map. I
" want a framework that accepts a list of dicts + a string & generates the
" keymappings.
nnoremap <silent> <Leader>e? :map <Leader>e<CR>
