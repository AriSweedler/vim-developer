function s:NotifyDebugToggle(tag, turning_off)
  let status = a:turning_off ? "off" : "on"
"   call popup_notification("Debug info for ".a:tag." is now ".status, #{
"   \ line: 0,
"   \ col: 0,
"   \ highlight: 'MoreMsg',
"   \ padding: [1,1,1,1],
"   \ })
endfunction

function s:Invoke(tag, lifecycle)
  let fxn = ["debug", a:tag, a:lifecycle]->join('#')
  try
    call function(fxn)()
  catch
    echom "Didn't invoke a lifecycle function for ".fxn." as it doesn't exist. This is not an error"
  endtry
endfunction

let g:ari_debug = {}
function! debug#toggle(tag)
  " Init if this is the first call
  if get(g:ari_debug, a:tag, 'uninitialized') == 'uninitialized'
    call s:Invoke(a:tag, "Init")
    let g:ari_debug[a:tag] = 'inactive'
  endif

  let l:augp = "toggleAriDebug".a:tag
  let turning_off = (g:ari_debug[a:tag] != 'inactive')
  call s:NotifyDebugToggle(a:tag, turning_off)

  " We were active when called. Let's deactivate
  if turning_off
    let g:ari_debug[a:tag] = 'inactive'
    execute "autocmd! ".l:augp." *"
    call s:Invoke(a:tag, "Inactive")
    " call popup_clear()
    return
  endif

  " Activate. Invoke 'display' at every cursormoved au event
  let g:ari_debug[a:tag] = 'popup'
  execute "augroup ".l:augp
    autocmd!
    execute printf('autocmd CursorMoved * call s:Invoke("%s", "Display")', a:tag)
  execute "augroup END"
  call s:Invoke(a:tag, "Display")
endfunction
