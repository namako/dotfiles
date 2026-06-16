-- init.lua
-- namakotti@gmail.com
-- last update: 2026/6/16

local opt = vim.opt
local g = vim.g
local map = vim.keymap.set

-----------------------------------------------------
-- For plugin
-----------------------------------------------------
-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugin settings
require("lazy").setup({
  { "ishan9299/nvim-solarized-lua" },
  { "projekt0n/github-nvim-theme" },
})

-----------------------------------------------------
-- vim normal config
-----------------------------------------------------
vim.cmd("syntax on")

opt.number = true
opt.list = true
opt.cindent = true
opt.autoindent = true
opt.laststatus = 2
opt.tabstop = 4
opt.ruler = true
opt.rulerformat = "%m%r%=%l/%L"
opt.showcmd = true
opt.wildmenu = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.showmatch = true
opt.ignorecase = true
opt.hidden = true
opt.shiftwidth = 4
opt.helplang = "en"
opt.expandtab = true

-- History size
opt.history = 10000
-- opt.wrap = false
opt.wrap = true

opt.helplang = "en"
opt.whichwrap = "h,l"
opt.scrolloff = 5
opt.swapfile = false
opt.backup = false
opt.backspace = { "indent", "eol", "start" }
opt.infercase = true
-- opt.cursorline = true

-- color theme
vim.cmd("syntax enable")
opt.background = "dark"
-- opt.termguicolors = true
vim.cmd("colorscheme solarized")
vim.cmd("colorscheme github_dark")

opt.modeline = true
opt.modelines = 5
opt.ttyfast = true
opt.startofline = false
opt.expandtab = true
opt.wrapscan = true
-- opt.title = true
opt.title = false
opt.showmode = true
opt.smartindent = true
opt.smarttab = true
opt.equalalways = false

-- 2016/10/06 appended
opt.smarttab = true
opt.clipboard = "unnamed"

-----------------------------------------------------
-- keymaps
-----------------------------------------------------
map("", "j", "gj")
map("", "k", "gk")

map("", "<S-h>", "^")
map("", "<S-l>", "$")

-- insert mode jkhl + delete
map("i", "<C-d>", "<Delete>")
map("i", "<C-k>", "<Up>")
map("i", "<C-j>", "<Down>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")

-- normal mode ENTER
map("", "<CR>", "A<CR><ESC>j")

-- full path map
map("i", "<Leader>path", "<C-R>=expand('%:p')<CR>")
-- map("i", "<TAB><TAB>", "<C-x><C-f>")

map("n", "q:", "<Nop>")
map("n", "q/", "<Nop>")
map("n", "q?", "<Nop>")

-- split
map("n", "s", "<Nop>")
map("n", "sj", "<C-w>j")
map("n", "sk", "<C-w>k")
map("n", "sl", "<C-w>l")
map("n", "sh", "<C-w>h")
map("n", "ss", ":<C-u>sp<CR>")
map("n", "sv", ":<C-u>vs<CR>")

map("n", ";", ":")
map("n", ":", ";")

map("i", "jj", "<ESC>", { silent = true })

-----------------------------------------------------
-- original config
-----------------------------------------------------

-- When in insert mode, add color to the status line
g.hi_insert =
  "highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none"

local slhlcmd = ""

local function get_highlight(hi)
  local hl = vim.api.nvim_exec2("highlight " .. hi, { output = true }).output
  hl = hl:gsub("[\r\n]", "")
  hl = hl:gsub("xxx", "")
 -- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン設定
require("lazy").setup({
  { "ishan9299/nvim-solarized-lua" },
}) return hl
end

local function status_line(mode)
  if mode == "Enter" then
    slhlcmd = "highlight " .. get_highlight("StatusLine")
    vim.cmd(g.hi_insert)
  else
    vim.cmd("highlight clear StatusLine")
    vim.cmd(slhlcmd)
  end
end

local insert_hook = vim.api.nvim_create_augroup("InsertHook", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
  group = insert_hook,
  callback = function() status_line("Enter") end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  group = insert_hook,
  callback = function() status_line("Leave") end,
})

