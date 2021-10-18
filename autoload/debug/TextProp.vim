" See ':help text-prop' for more info
function! debug#TextProp#Init()
  echom "Initializing text prop!"
endfunction

function! debug#TextProp#Display()
  " Get the textprops
  let [_, lnum, col, _, _] = getcurpos()
  let lst = prop_list(lnum, {'col': col})->join(',')

  " Decide what message to show
  let text = "Properties on the cursor: " . lst
  if lst == ""
    let text = "No text properties on the cursor"
  endif

  " Show
  call popup_atcursor(text, {})
endfunction
