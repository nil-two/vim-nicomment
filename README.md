vim-nicomment
=============

Flow comments on your Vim.
It's inspired by [ニコニコ動画](https://www.nicovideo.jp/).

Requirements
------------

- Vim8.1.1561 or later

Usage
-----

It flows comments when `:NicommentStart` executed.
It stop flowing comments when `:NicommentStop` executed.

Configuration
-------------

### `g:nicomment_max_lineno`

Number of lines used by vim-nicomment.
Default is `10`.

### `g:nicomment_comment_block_timer_start_time`

The argument of `timer_start()` used when comment flower flows comment.
Default is `100`.

### `g:nicomment_comment_generator`

The comment generator used by comment flower.
If it doesn't exists, comment flower use builtin comment generator.

`g:nicomment_comment_generator` is an dictionary which have funcref as `generate`.
`g:nicomment_comment_generator.generate` is called without no arguments every 0.1 seconds.
If `g:nicomment_comment_generator.generate` returns string, comment flower flows the string as a comment.
If `g:nicomment_comment_generator.generate` returns v:null, comment flower does nothing.

#### Example

```vim
" It generates claps
let g:nicomment_comment_generator = {}
function! g:nicomment_comment_generator.generate()
  if !has_key(self, 'rand')
    " It requires vital.vim
    let V = vital#of('vital')
    let Xor128 = V.import('Random.Xor128')
    let self.rand = Xor128.new_generator()
  endif

  if abs(self.rand.next() % 10) == 0
    return repeat('8', abs(self.rand.next() % 20) + 4)
  else
    return v:null
  endif
endfunction
```

License
-------

MIT License

Author
------

nil2 <nil2@nil2.org>
