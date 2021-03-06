let s:suite = themis#suite('parser')
let s:assert = themis#helper('assert')

function! s:suite.sorter_rank()
  if !has('lua')
    return
  endif

  for has_lua in range(2)
    call s:assert.equals(map(unite#filters#sorter_rank#_sort(
          \ [{'word' : 'g/vimrc.ln'}, {'word' : 'gvimrc.ln'}],
          \  'gvimr', has_lua), 'v:val.word'), ['gvimrc.ln', 'g/vimrc.ln'])
    call s:assert.equals(map(unite#filters#sorter_rank#_sort(
          \ [{'word' : 'g/vimrc.ln'}, {'word' : 'gvimrc.ln'}],
          \  'gvimrc', has_lua), 'v:val.word'), ['gvimrc.ln', 'g/vimrc.ln'])
    call s:assert.equals(map(unite#filters#sorter_rank#_sort(
          \ [{'word' : 'ab12345js12345tt'}, {'word' : 'ab.js.tt'}],
          \  'abjstt', has_lua), 'v:val.word'), ['ab.js.tt', 'ab12345js12345tt'])
    call s:assert.equals(map(unite#filters#sorter_rank#_sort(
          \ [{'word' : 'source/r', 'action__path' : ''},
          \  {'word' : 'sort.vim', 'action__path' : ''}],
          \  'so', has_lua), 'v:val.word'), ['sort.vim', 'source/r'])
    call s:assert.equals(map(unite#filters#sorter_rank#_sort(
          \ [{'word' : 'spammers.txt', 'action__path' : ''},
          \  {'word' : 'thread_parsing.py', 'action__path' : ''}],
          \  'pars', has_lua), 'v:val.word'),
          \ ['thread_parsing.py', 'spammers.txt'])
  endfor
endfunction

function! s:suite.sorter_rank()
  call s:assert.equals(unite#candidates#_group_post_filters([
        \ {'word' : 'foo', 'group' : 'bar'},
        \ {'word' : 'bar', 'group' : 'baz'},
        \ {'word' : 'qux', 'group' : 'baz'}]), [
        \ {'word' : 'bar', 'is_dummy' : 1},
        \ {'word' : 'foo', 'group' : 'bar'},
        \ {'word' : 'baz', 'is_dummy' : 1},
        \ {'word' : 'bar', 'group' : 'baz'},
        \ {'word' : 'qux', 'group' : 'baz'},
        \])
endfunction

" vim:foldmethod=marker:fen:
