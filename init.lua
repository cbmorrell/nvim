-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure plugins ]]
-- This will call setup for LazyVim on all lua files in lua/plugins/. It merges all the tables in those files into one table and installs all the plugins.
-- For more info see https://github.com/folke/lazy.nvim#-structuring-your-plugins
require("lazy").setup("plugins")

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Configure Telescope ]]
-- (fuzzy finder)
require 'telescope-setup'

-- [[ Configure Treesitter ]]
-- (syntax parser for highlighting)
require 'treesitter-setup'

-- [[ Configure LSP ]]
-- (Language Server Protocol)
require 'lsp-setup'

-- [[ Configure nvim-cmp ]]
-- (completion)
require 'cmp-setup'

-- Import custom commands
require 'commands'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
