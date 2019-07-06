let s:V = vital#nicomment#new()
let s:Xor128 = s:V.import('Random.Xor128')

let s:comment_generator = {
\   'rand': v:null,
\ }

function! nicomment#builtin#comment_generator#new() abort
  let comment_generator = deepcopy(s:comment_generator)
  let comment_generator.rand = s:Xor128.new_generator()
  return comment_generator
endfunction

let s:comments = [
\   {g -> '便利'},
\   {g -> '感極まってきた'},
\   {g -> 'すごい'},
\   {g -> 'わこつ'},
\   {g -> 'なんだちょっとうまい人か'},
\   {g -> '初見'},
\   {g -> 'わからん'},
\   {g -> 'うめぇ'},
\   {g -> '難易度'},
\   {g -> 'ｗｗｗ'},
\   {g -> strftime('もう%H時%M分か')},
\   {g -> expand('%:t') . 'を編集中だよ'},
\ ]

function! s:comment_generator.generate() abort
  if abs(self.rand.next() % 10) == 0
    return s:comments[abs(self.rand.next() % len(s:comments))](self)
  else
    return v:null
  endif
endfunction
