" .vimrc
" Takuya.Usami@sony.com
" ver.20171020

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim normal config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

set number
set list
set cindent
set autoindent
set laststatus=2
set tabstop=4
set ruler
set rulerformat=%m%r%=%l/%L
set showcmd
set wildmenu
set smartcase
set incsearch
set hlsearch
set showmatch
set ignorecase
set hidden
set shiftwidth=4
set helplang=en
set expandtab

" History size
set history=10000
"set nowrap
set wrap

set helplang=en
set whichwrap=h,l
set scrolloff=5
set noswapfile
set nobackup
set backspace=indent,eol,start
set infercase
"set cursorline

" color theme
syntax enable
set background=dark
set termguicolors
"colorscheme molokai
"colorscheme solarized
colorscheme NeoSolarized


set modeline
set modelines=5
set ttyfast
set nostartofline
set expandtab
set wrapscan
"set title
set notitle
set showmode
set smartindent
set smarttab
set noequalalways

"2016/10/06 appended
set smarttab
set clipboard=unnamed




"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keymaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap j gj
noremap k gk

noremap <S-h> ^
noremap <S-l> $

" insert mode jkhl + delete
inoremap <C-d> <delete>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" normal mode ENTER
noremap <CR> A<CR><ESCsj

" full path map
inoremap <Leader>path <C-R>=expand('%:p')<CR>
"inoremap <TAB><TAB> <C-x><C-f>

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" split
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>

nnoremap ; :
nnoremap : ;

inoremap <silent> jj <ESC>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" original config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

" When the insert mode, add color
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
    augroup InsertHook
     autocmd!
     autocmd InsertEnter * call s:StatusLine('Enter')
     autocmd InsertLeave * call s:StatusLine('Leave')
    augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
     silent exec g:hi_insert
  else
     highlight clear StatusLine
     silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


