function! debug#ARI#Init()
  let s:cursor_counter = 0
endfunction

function! debug#ARI#Inactive()
  let s:cursor_counter = 0
endfunction

function! debug#ARI#Display()
  let s:cursor_counter = s:cursor_counter + 1
  let text = "[ARI] cursorhold counter: " . s:cursor_counter
  call popup_atcursor(text, {})
endfunction
