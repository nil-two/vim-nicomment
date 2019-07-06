let s:comment_block = {
\   'comment':         v:null,
\   'width':           v:null,
\   'lineno':          v:null,
\   'colno':           v:null,
\   'popup_id':        v:null,
\   'popup_displayed': v:false,
\   'finished':        v:false,
\ }

function! nicomment#comment_block#new(comment, lineno, colno) abort
  let comment_block = deepcopy(s:comment_block)
  let comment_block.comment = a:comment
  let comment_block.width   = strwidth(a:comment)
  let comment_block.lineno  = a:lineno
  let comment_block.colno   = a:colno + comment_block.width
  return comment_block
endfunction

function! s:comment_block.resume(timer_id) abort
  if self.finished
    return
  endif

  if self.popup_id == v:null
    let self.popup_id = popup_create(self.comment, {
    \   'pos':       'topright',
    \   'line':      self.lineno,
    \   'col':       self.colno,
    \   'wrap':      v:false,
    \   'maxwidth':  max([min([self.width, &columns - self.colno + self.width]), 0]),
    \   'hidden':    v:true,
    \ })
  end

  if !self.popup_displayed && self.colno - self.width < &columns
    let self.popup_displayed = v:true
    call popup_show(self.popup_id)
  end

  let self.colno = self.colno - 1
  while self.width > 0 && self.colno - self.width < 0
    let self.comment = substitute(self.comment, '^.', '', '')
    let self.width   = strwidth(self.comment)
    call popup_settext(self.popup_id, self.comment)
  endwhile

  if self.width == 0
    call timer_stop(a:timer_id)
    call popup_close(self.popup_id)
    let self.finished = v:true
    return
  endif

  call popup_move(self.popup_id, {
  \   'pos':      'topright',
  \   'line':     self.lineno,
  \   'col':      self.colno,
  \   'wrap':     v:true,
  \   'maxwidth': max([min([self.width, &columns - self.colno + self.width]), 0]),
  \ })
endfunction
