-- init.lua

local opt = vim.opt
local map = vim.keymap.set

-----------------------------------------------------
-- Plugin
-----------------------------------------------------
-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-- plugin settings
require("lazy").setup({
  { "projekt0n/github-nvim-theme" },
  -- filer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- syntax highlight (main branch: requires the tree-sitter CLI)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
  },
  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
})

-- nvim-tree
require("nvim-tree").setup()
map("n", "<C-n>", "<Cmd>NvimTreeToggle<CR>")  -- Ctrl+nで開閉

-- treesitter
require("nvim-treesitter").install({ "lua", "python", "javascript" })  -- 必要な言語追加
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  callback = function(args)
    -- start highlighting only when a parser exists for this filetype
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- lualine
require("lualine").setup({
  options = { theme = "auto" }
})

-----------------------------------------------------
-- vim normal config
-----------------------------------------------------
opt.number = true
opt.list = true
opt.cindent = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.ruler = true
opt.rulerformat = "%m%r%=%l/%L"
opt.showcmd = true
opt.showmode = true
opt.smartcase = true
opt.ignorecase = true
opt.infercase = true
opt.incsearch = true
opt.hlsearch = true
opt.wrapscan = true
opt.showmatch = true
opt.hidden = true
opt.helplang = "en"
opt.history = 10000
opt.wrap = true
opt.whichwrap = "h,l"
opt.scrolloff = 5
opt.swapfile = false
opt.backup = false
opt.backspace = { "indent", "eol", "start" }
opt.modeline = true
opt.modelines = 5
opt.startofline = false
opt.title = false
opt.equalalways = false
opt.clipboard = "unnamed"

-- color theme
opt.background = "dark"
vim.cmd.colorscheme("github_dark")

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

-- normal mode ENTER: open a new line below
-- (skip in quickfix/help/nvim-tree etc. so <CR> keeps working there)
map("n", "<CR>", function()
  return vim.bo.buftype == "" and "A<CR><Esc>j" or "<CR>"
end, { expr = true })

-- full path map
map("i", "<Leader>path", "<C-R>=expand('%:p')<CR>")

map("n", "q:", "<Nop>")
map("n", "q/", "<Nop>")
map("n", "q?", "<Nop>")

-- split
map("n", "s", "<Nop>")
map("n", "sj", "<C-w>j")
map("n", "sk", "<C-w>k")
map("n", "sl", "<C-w>l")
map("n", "sh", "<C-w>h")
map("n", "ss", "<Cmd>split<CR>")
map("n", "sv", "<Cmd>vsplit<CR>")

map("n", ";", ":")
map("n", ":", ";")

map("i", "jj", "<Esc>", { silent = true })
