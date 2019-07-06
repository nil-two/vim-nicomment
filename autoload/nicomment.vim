let s:global_comment_flower_timer_id = v:null

function! nicomment#start() abort
  let comment_generator = exists('g:nicomment_comment_generator') ? g:nicomment_comment_generator : nicomment#builtin#comment_generator#new()
  let comment_flower    = nicomment#comment_flower#new(g:nicomment_max_lineno, comment_generator)
  let s:global_comment_flower_timer_id = timer_start(100, comment_flower.resume, {'repeat':  -1})
endfunction

function! nicomment#stop() abort
  " FIXME: popup_clear()をここで使うのはよくないが他の方法を思いつかない。
  call popup_clear()
  call timer_stop(s:global_comment_flower_timer_id)
endfunction
