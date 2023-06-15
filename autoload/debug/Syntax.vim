function! debug#Syntax#Init()
  echom "Loading scriptease"
  if !exists('g:loaded_scriptease')
    packadd scriptease
  endif
endfunction()

function! debug#Syntax#Display()
  " Error
  if g:ari_debug["Syntax"] == "inactive"
    echom 'Don`t call SyntaxDisplay() when g:ari_debug["Syntax"] == "inactive"'
    return
  endif

  " Default
  if g:ari_debug["Syntax"] == "active"
    echom scriptease#synnames()->join(", ")
    return
  endif

  " Popup
  if g:ari_debug["Syntax"] == "popup"
    echo scriptease#synnames()
    return
  endif
endfunction
