" cursor-flasher - flashing cursor after gone missing
"
" Author: Yuki Yoshimine <yuki.uthman@gmail.com>
" Source: https://github.com/yuki-uthman/vim-cursor-flasher


if exists("g:loaded_cursor_flasher")
  finish
endif
let g:loaded_cursor_flasher = 1

let s:save_cpo = &cpo
set cpo&vim

augroup cursor_flasher
    au!

    au FocusGained * call flasher#cursor#flash()
    au FocusLost   * call flasher#cursor#off()
augroup end

let &cpo = s:save_cpo
unlet s:save_cpo
