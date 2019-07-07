let s:comment_flower = {
\   'max_lineno':           v:null,
\   'comment_generator':    v:null,
\   'registance_by_lineno': v:null,
\ }

function! nicomment#comment_flower#new(max_lineno, comment_generator) abort
  let comment_flower = deepcopy(s:comment_flower)
  let comment_flower.max_lineno           = a:max_lineno + 1
  let comment_flower.comment_generator    = a:comment_generator
  let comment_flower.registance_by_lineno = repeat([0], comment_flower.max_lineno)
  return comment_flower
endfunction

function! s:comment_flower.resume(timer_id) abort
  let comment = v:null
  if len(g:nicomment_comments_queue) >= 1
    let comment = remove(g:nicomment_comments_queue, 0)
  else
    let comment = self.comment_generator.generate()
  endif

  if type(comment) == v:t_string
    let min_registance   = v:null
    let min_registance_i = v:null
    for i in range(self.max_lineno)
      let registance = self.registance_by_lineno[i] + i*10
      if min_registance == v:null || registance < min_registance
        let min_registance   = registance
        let min_registance_i = i
      endif
    endfor

    let lineno        = min_registance_i
    let colno         = &columns
    let comment_block = nicomment#comment_block#new(comment, lineno, colno)
    call timer_start(g:nicomment_comment_block_timer_start_time, comment_block.resume, {'repeat':  -1})

    let self.registance_by_lineno[min_registance_i] = self.registance_by_lineno[min_registance_i] + 50
  endif

  for i in range(self.max_lineno)
    if self.registance_by_lineno[i] > 0
      let self.registance_by_lineno[i] = self.registance_by_lineno[i] - 1
    endif
  endfor
endfunction
