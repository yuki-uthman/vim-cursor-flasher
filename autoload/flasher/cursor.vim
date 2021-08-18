
function! flasher#cursor#flash()
  call s:flash()
endfunction

function! s:get_user_config() "{{{
  let highlight = get(g:, 'cursor_flasher_highlight', 'IncSearch')
  let repeat = get(g:, 'cursor_flasher_repeat', 5)
  let duration = get(g:, 'cursor_flasher_duration', 100)

  return {'highlight': highlight, 'repeat': repeat * 2 - 1, 'duration': duration}
endfunction "}}}

function! s:init_flash() "{{{

  return { 
        \'winid': 0,
        \'id': 0,
        \'state': 0,
        \'toggle_timer': 0 }

endfunction "}}}

function! s:flash_on(timer_id) "{{{



  exec 'highlight! link CursorLine ' . s:user_config.highlight

  set cursorline

  " get the cursor line number
  " let lnum = getcurpos()[1]

  " matchaddpos
  " let id = matchaddpos(s:user_config.highlight, [lnum])

  " let s:flash.id = id
  let s:flash.state = 1
  " let s:flash.winid = win_getid()

endfunction "}}}

function! s:flash_off(timer_id) "{{{

  " call matchdelete(s:flash.id, s:flash.winid)

  set nocursorline
  highlight! link CursorLine NONE

  " let s:flash.winid = 0
  " let s:flash.id = 0
  let s:flash.state = 0

endfunction "}}}

function! s:flash_toggle(timer_id) "{{{
  if s:flash.state
    call s:flash_off(0)
  else
    call s:flash_on(0)
  endif
endfunction "}}}

function! s:flash() abort "{{{

  let s:user_config = s:get_user_config()

  if !exists('s:flash')
    let s:flash = s:init_flash()
  endif

  if s:flash.toggle_timer > 0
    call timer_stop(s:flash.toggle_timer)
    if s:flash.state
      call s:flash_off(0)
    endif
  endif

  if s:flash.id > 0
    call s:flash_off(0)
  endif

  call s:flash_on(0)

  let s:toggle_timer = timer_start(
        \s:user_config.duration,
        \function('s:flash_toggle'),
        \{'repeat': s:user_config.repeat})

  let s:flash.toggle_timer = s:toggle_timer

endfunction "}}}

