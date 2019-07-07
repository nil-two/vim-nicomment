if exists('g:loaded_nicomment')
  finish
endif
let g:loaded_nicomment = 1

let g:nicomment_comments_queue = []

let g:nicomment_max_lineno                     = get(g:, 'nicomment_max_lineno', 10)
let g:nicomment_comment_block_timer_start_time = get(g:, 'nicomment_comment_block_timer_start_time', 100)
" let g:nicomment_comment_generator = <dictionaly> (It is also configurable)

command! -bar NicommentStart call nicomment#start()
command! -bar NicommentStop  call nicomment#stop()
command! -bar -nargs=* NicommentFlow call nicomment#flowComment(<q-args>)
