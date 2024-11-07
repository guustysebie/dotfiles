-- Basic Settings
vim.opt.compatible = false             -- Disable compatibility to old-time vi
vim.opt.showmatch = true               -- Show matching brackets
vim.opt.ignorecase = true              -- Case insensitive search
vim.opt.mouse = "a"                    -- Enable mouse support
vim.opt.hlsearch = true                -- Highlight search results
vim.opt.incsearch = true               -- Incremental search
vim.opt.tabstop = 4                    -- Number of columns occupied by a tab
vim.opt.softtabstop = 4                -- Number of spaces in tab when editing
vim.opt.expandtab = true               -- Convert tabs to spaces
vim.opt.shiftwidth = 4                 -- Width for autoindents
vim.opt.autoindent = true              -- Auto indent new lines
vim.opt.number = true                  -- Show line numbers
vim.opt.wildmode = {"longest", "list"} -- Bash-like tab completions
vim.opt.colorcolumn = "120"             -- Set an 80 column border
--vim.opt.cursorline = true              -- Highlight current line
vim.opt.ttyfast = true                 -- Speed up scrolling
vim.opt.clipboard = "unnamedplus"      -- Use system clipboard

-- Syntax Highlighting and Filetype Detection
vim.cmd("filetype plugin indent on")   -- Enable file type detection and plugins
vim.cmd("syntax on")                   -- Enable syntax highlighting

-- Optional Settings (Uncomment if needed)
-- vim.opt.spell = true                  -- Enable spell check
vim.opt.swapfile = false              -- Disable creating swap files
vim.opt.backupdir = vim.fn.expand("~/.cache/vim") -- Directory for backup files



vim.g.have_nerd_font = false

-- Make line numbers default
vim.opt.relativenumber = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.cmd [[colorscheme habamax]]

