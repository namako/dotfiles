-- init.lua
-- ver.20220812
--
----------------------------------------------------
-- nvim config
----------------------------------------------------

-- global
vim.o.laststatus = 2
vim.o.ruler = true
vim.o.rulerformat = %m%r%=%l/%L
vim.o.showcmd = true
vim.o.wildmenu = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.hidden = true
vim.o.helplang = en
vim.o.history = 10000
vim.o.whichwrap = h,l
vim.o.scrolloff = 5
vim.o.nobackup = true
vim.o.backspace = indent,eol,start
vim.o.background = dark
vim.o.termguicolors = true
vim.o.modelines = 5
vim.o.ttyfast = true
vim.o.nostartofline = true
vim.o.wrapscan = true
vim.o.title = false
vim.o.showmode = true
vim.o.smarttab = true
vim.o.noequalalways = true
vim.o.clipboard = unnamed

-- local to window
vim.wo.number = true
vim.wo.list = true
--vim.wo.nowrap = true
vim.wo.wrap = true

-- local to buffer
vim.bo.syntax = ON
vim.bo.cindent = true
vim.bo.autoindent = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.bo.expandtab = true
vim.bo.noswapfile = true
vim.bo.infercase = true
vim.bo.modeline = true
vim.bo.smartindent = true

" color theme
"colorscheme molokai
"colorscheme solarized
colorscheme NeoSolarized

----------------------------------------------------
-- keymaps
----------------------------------------------------
noremap j gj
noremap k gk

noremap <S-h> ^
noremap <S-l> $

-- insert mode jkhl + delete
inoremap <C-d> <delete>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

-- normal mode ENTER
noremap <CR> A<CR><ESCsj

-- full path map
inoremap <Leader>path <C-R>=expand('%:p')<CR>
"inoremap <TAB><TAB> <C-x><C-f>

nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

-- split
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

