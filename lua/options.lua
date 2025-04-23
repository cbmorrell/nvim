-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
-- Set color scheme
vim.cmd.colorscheme 'vscode'

-- Setup line numbers (show relative in normal mode and absolute in insert mode)
vim.opt.nu = true
vim.opt.relativenumber = true

local group = vim.api.nvim_create_augroup('line-numbers', {clear = true})
vim.api.nvim_create_autocmd({'InsertLeave'}, {
  group = group,
  command = 'if &nu && mode() != "i" | set rnu   | endif'
})
vim.api.nvim_create_autocmd({'InsertEnter'}, {
  group = group,
  command = 'if &nu | set nornu | endif'
})

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.scrolloff = 10

vim.o.complete = '.'
-- vim: ts=2 sts=2 sw=2 et
