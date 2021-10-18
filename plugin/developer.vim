""""""""""""""""""""""""""""" vimscript development """""""""""""""""""""""""{{{
" Shortcuts to source/edit your vimrc/current file/ftplugin file {{{

" We need a function to lazily evaluate the filetype. If we hard-coded it with
" a mapping to ':tabe "$HOME/.vim/after/ftplugin/" . &filetype .  ".vim"<CR>', then
" we'd have to make a new mapping with every new buffer. That could be done
" with an autocommand, I suppose. But at this point, let's just use a function
" to delay evaluation of filetype until we invoke the function!

" Get a path using the filetype of the current file
function! Evaluate_path(path_start)
  return a:path_start . &filetype . ".vim"
endfunction

" source my {vimrc,current,ftplugin,syntax} file - useful for developing
nnoremap <silent> <Leader>sv :source $MYVIMRC<CR>
nnoremap <silent> <Leader>so :source %<CR>
nnoremap <silent> <Leader>sf :source <C-r>=Evaluate_path("$HOME/.vim/after/ftplugin/")<CR><CR>
nnoremap <silent> <Leader>ss :source <C-r>=Evaluate_path("$HOME/.vim/after/syntax/")<CR><CR>

" edit my {vimrc,ftplugin,syntax} file - useful for developing
nnoremap <silent> <Leader>ev :tabe $MYVIMRC<CR>
nnoremap <silent> <Leader>ef :tabe <C-r>=Evaluate_path("$HOME/.vim/after/ftplugin/")<CR><CR>
nnoremap <silent> <Leader>es :tabe <C-r>=Evaluate_path("$HOME/.vim/after/syntax/")<CR><CR>
nnoremap <silent> <Leader><Leader>es :tabe <C-r>=Evaluate_path("$VIMRUNTIME/syntax/")<CR><CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
let g:ari_debug = {}

function SyntaxInit()
  if !exists('g:loaded_scriptease')
    packadd scriptease
  endif
endfunction()

function SyntaxDisplay()
  echom scriptease#synnames()->join(", ")
endfunction

function! s:ToggleDebug(tag)
  " Init if this is the first call
  if get(g:ari_debug, a:tag, 'uninitialized') == 'uninitialized'
    call function(a:tag."Init")()
    execute printf('call function("%s")()', a:tag."Init")
    let g:ari_debug[a:tag] = 'inactive'
  endif

  let l:augp = "toggleDebug".a:tag

  " We were active when called. Let's deactivate
  if g:ari_debug[a:tag] != 'inactive'
    let g:ari_debug[a:tag] = 'inactive'
    execute "autocmd! ".l:augp." *"
    return
  endif

  " Activate. Invoke 'display' at every cursormoved au event
  let g:ari_debug[a:tag] = 'active'
  execute "augroup ".l:augp
    autocmd!
    execute printf('autocmd CursorMoved * call function("%s")()', a:tag."Display")
  execute "augroup END"
endfunction
command! ToggleSyntaxerDebug call s:ToggleDebug('Syntax')
"}}}
"{{{ Refresh syntax
command! RefreshSyntax syntax clear <Bar> let &filetype=&filetype
"}}}
"{{{ Let us run Scriptnames before loading the pack.
" scriptease will overwrite the meaning of this command
command! Scriptnames packadd scriptease <Bar> Scriptnames
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
"""""""""""""""""""""""""""" cursorhold autocmd """""""""""""""""""""""""""" {{{
let s:cursor_debugging = 0
let s:cursor_counter = 0
function! s:ToggleDebugCursorhold()
  if s:cursor_debugging == 1
    autocmd! debugCursorhold *

    let s:cursor_debugging = 0
  else
    augroup debugCursorhold
      autocmd!

      autocmd cursorhold * let s:cursor_counter = s:cursor_counter + 1 | call s:SayStuff()
    augroup END

    let s:cursor_debugging = 1
  endif
  echo "Cursorhold debugging is now " . s:cursor_debugging
endfunction

" Helper function. Just update this and source the file to update what
" cursorhold says
function! s:SayStuff()
  echom "Cursorhold counter: " . s:cursor_counter
  "echom "... In dotfiles: " . lib#in_dotfiles() . "... gge = >" . g:gitgutter_git_executable
endfunction
command! ToggleCursorholdCounter call s:ToggleDebugCursorhold()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
"""""""""""""""""""""""""""" cursorhold autocmd """""""""""""""""""""""""""" {{{
"""""""""""""""""""""""""""""""" properties """""""""""""""""""""""""""""""" {{{
let s:prop_debugging = 0
let s:prop_counter = 0
function! s:ToggleDebugPropHold()
  if s:prop_debugging == 1
    autocmd! debugPropHold *

    let s:prop_debugging = 0
  else
    augroup debugPropHold
      autocmd!

      autocmd cursorhold * let s:prop_counter = s:prop_counter + 1 | call s:PropSayStuff()
    augroup END

    let s:prop_debugging = 1
  endif
  echo "PropHold debugging is now " . s:prop_debugging
endfunction

" Helper function. Just update this and source the file to update what
" cursorhold says
function! s:PropSayStuff()
  let [_, lnum, col, off, curswant] = getcurpos()
  echom "Properties on the cursor: " . prop_list(lnum, {'col': col})->join(',')
  "echom "... In dotfiles: " . lib#in_dotfiles() . "... gge = >" . g:gitgutter_git_executable
endfunction
command! TogglePropHoldCounter call s:ToggleDebugPropHold()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" }}}
" TODO unify the debugging autocmds somehow?
" Make a framework.
" * Give a name
" * It is toggleable
" * It can accept any autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
" call GetText()->popup_atcursor({})
" So op!
