return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {opleader = {line = '<leader>/'}} },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require("nvim-autopairs").setup {}
      -- If you want to automatically add `(` after selecting a function or method
      -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      -- local cmp = require('cmp')
      -- cmp.event:on(
      --   'confirm_done',
      --   cmp_autopairs.on_confirm_done()
      -- )
      -- require('nvim-autopairs.completion.compe')
    end,
  },
  'tpope/vim-surround',
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat'
    },
    -- config = function()
    --   require('leap').create_default_mappings()
    -- end
  },
  'mbbill/undotree',
  {
    'kkoomen/vim-doge',
    config = function()
      -- Install if it hasn't already
      vim.cmd('call doge#install()')

      -- Set python-specific settings
      vim.g.doge_python_settings = {
        single_quotes = 0,
        omit_redundant_param_types = 0
      }
      vim.g.doge_doc_standard_python = 'sphinx'

    end
  },
  {
    'olimorris/codecompanion.nvim',
    opts = {
      adapters = {
        qwencoder = function()
          return require('codecompanion.adapters').extend('ollama', {
            name = 'qwencoder',  -- give adapter a name to differentiate from ollama adapter
            schema = {
              model = {
                default = 'qwen2.5-coder:latest'
              }
            }
          })
        end,
        codegemma = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'codegemma',
              schema = {
                model = {
                  default = 'codegemma:7b'
                }
              }
            })
        end,
        qwen3 = function()
            return require('codecompanion.adapters').extend('ollama', {
              name = 'qwen3',
              schema = {
                model = {
                  default = 'qwen3:1.7b'
                }
              }
            })
        end
      },
      strategies = {
        chat = {
          adapter = 'qwen3',
        },
        inline = {
          adapter = 'qwen3',
        },
        cmd = {
          adapter = 'qwen3',
        }
      }
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter'
    }
  }
}

