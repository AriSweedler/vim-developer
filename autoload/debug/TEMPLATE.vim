function! debug#TEMPLATE#Init()
  " Load all the tmux colors
  runtime $VIMRUNTIME/syntax/tmux.vim<CR>
  let s:cursor_counter = 0
endfunction

function! debug#TEMPLATE#Inactive()
  let s:cursor_counter = 0
endfunction

function! debug#TEMPLATE#Display()
  let s:cursor_counter = s:cursor_counter + 1
  let text = "cursorhold counter: " . s:cursor_counter
  call popup_atcursor(text, {})
endfunction

