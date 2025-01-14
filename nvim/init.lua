--choco install fdpre requisites
--https://github.com/sharkdp/fd
--ripgrep
-- on windows choco install mingw on linux just need a c compiler and make I suppose

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
vim.opt.signcolumn = "yes"             -- allow space for thing
--vim.opt.cursorline = true              -- Highlight current line
vim.opt.ttyfast = true                 -- Speed up scrolling
vim.opt.clipboard = "unnamedplus"      -- Use system clipboard
vim.opt.wrap = false

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
vim.opt.listchars = { tab = '?? ', trail = '??', nbsp = '???' }


-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.cmd [[colorscheme default]]

-- REMAPS --
vim.g.mapleader = ","
-- open netrw 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)






--  Plugins ----
--
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup({
    spec = {
        -- add your plugins here
        {
            'nvim-telescope/telescope.nvim', 
            tag = '0.1.8',
            dependencies = {
                'nvim-lua/plenary.nvim',
                { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
            },
            config = function()
                require('telescope').setup {
                    pickers = {
                        find_files = {
                            theme="ivy"
                        },
                        live_grep = {
                            theme="ivy"
                        }
                    }
                }
            end
        },
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                require'nvim-treesitter.configs'.setup {
                    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                    ensure_installed = { 
                        "c", 
                        "rust",
                        "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "java" },
                        auto_install = false,

                        highlight = {
                            enable = true,

                            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                            disable = function(lang, buf)
                                local max_filesize = 100 * 1024 -- 100 KB
                                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                                if ok and stats and stats.size > max_filesize then
                                    return true
                                end
                            end,
                            additional_vim_regex_highlighting = false,
                        },
                    }

                end
            },
        },
        
        {
            'neovim/nvim-lspconfig',
            dependencies = { 'saghen/blink.cmp' },
            opts = {
                servers = {
                    lua_ls = {}
                }
            },
            config = function()
                local capabilities = require('blink.cmp').get_lsp_capabilities()
                local lspconfig = require('lspconfig')
                lspconfig['lua-ls'].setup({ capabilities = capabilities })
            end

        },
        {
            'saghen/blink.cmp',
            dependencies = 'rafamadriz/friendly-snippets',

            version = 'v0.*',
            opts = {
               keymap = { preset = 'default' },
                appearance = {
                    use_nvim_cmp_as_default = true,
                    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono'
                },

                -- default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                    -- optionally disable cmdline completions
                    -- cmdline = {},
                },
                -- experimental signature help support
                -- signature = { enabled = true }
            },
        },
        -- Configure any other settings here. See the documentation for more details.
        -- colorscheme that will be used when installing plugins.
--        install = { colorscheme = { "default" } },
        -- automatically check for plugin updates
        checker = { enabled = false }
    })


    -- Telescope config this is the thing for fuzzy finding
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


    -- ============================== TERMINAL CONFIG =============================
    -- exit terminal
    vim.api.nvim_set_keymap('t', '<leader>te', [[<C-\><C-n>]], { noremap = true, silent = true })
    vim.api.nvim_create_autocmd('TermOpen', {
        group = vim.api.nvim_create_augroup('custom-rem-open',{clear =true}),
        callback = function()
            vim.opt.number = false
            vim.opt.relativenumber = false
        end
    })
    -- open a small terminal
    vim.keymap.set("n", "<leader>ts", function() 
        vim.cmd.vnew()
        vim.cmd.term()
        vim.cmd.wincmd("J")
        vim.api.nvim_win_set_height(0,10)
    end)

    -- ============================== Execute lua =============================
    vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
    vim.keymap.set("n", "<leader>x", ":.lua<CR>")
    vim.keymap.set("v", "<leader>x", ":lua<CR>")

    -- custom listener to highlight text on yanking
    vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}),
        callback = function()
            vim.highlight.on_yank()
        end
    })
