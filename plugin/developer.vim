" Give access to the Developer commands.
" Edit or source the relevant files in just a few keystrokes

" Developer command ::= <Leader><action><file>
"
" Leader ::= <Leader>
"
" action ::=
"   s (source)
" | e (tabedit)
" | E (edit!)
"
" file ::=
"   o (current file)
" | v (vimrc)
" | f (ftplugin)
" | s (syntax)
" | F (system ftplugin)
" | S (system syntax)
" | p<plug_file> (inside the registered plugin)
"
" plug_file ::=
"   a (autoload for the named submodule)
" | p: (plugin for the named submodule)
" | f: (ftplugin)
" | s: (syntax)

" Create the mappings
call developer#init()
nnoremap <silent> <Leader>ep :echom "WARN: If you want to use '\<Leader>ep{s,f}' then have a plugin register itself with 'call developer#register_plugin(...)"<CR>
nnoremap gT :echom "WARN: To open a new tab at current buffer, use developer's '\<Leader>eo' instead"<CR>
