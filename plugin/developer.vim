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
"""""""""""""""""""""""""""""""""""" Syntax """""""""""""""""""""""""""""""""{{{
"{{{ Show syntax stack every time you move cursor (requires tpope's scriptease)
let s:syntax_debugging = 0
function! s:ToggleDebugSyntax()
  if !exists('g:loaded_scriptease')
    packadd scriptease
  endif

  if s:syntax_debugging == 1
    autocmd! debugSyntax *

    let s:syntax_debugging = 0
  else
    augroup debugSyntax
      autocmd!

      autocmd CursorMoved * normal zS
    augroup END

    let s:syntax_debugging = 1
  endif
  echo "Syntax debugging in now " . s:syntax_debugging
endfunction
command! ToggleSyntaxerDebug call s:ToggleDebugSyntax()
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
" TODO unify the debugging autocmds somehow?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
