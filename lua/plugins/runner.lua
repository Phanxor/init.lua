return {
    {
        'let-def/texpresso.vim',
    },
    {
        'lervag/vimtex',
        lazy = false,
    },
    -- {
    --     'okuuva/auto-save.nvim',
    --     ft = { 'tex', 'bib' },
    --     cmd = { 'ASToggle' },
    --     opts = {
    --         condition = function(buf)  -- whether or not to auto-save
    --             local ft = vim.fn.getbufvar(buf, "&filetype")
    --             if (ft == 'tex' or ft == 'bib') then
    --                 return true
    --             end
    --             return false
    --         end,
    --         trigger_events = {
    --             cancel_deferred_save = {},  -- don't cancel saves
    --             defer_save = { 'InsertLeave', 'TextChanged', 'TextChangedI' },  -- auto-save even in insert mode
    --         },
    --         debounce_delay = 1000,  -- (ms) Don't save TOO often.
    --     }
    -- },
    {
        'Zeioth/compiler.nvim',
        cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
        depedencies = {
            'stevearc/overseer.nvim',
            'nvim-telescope/telescope.nvim'
        },
        opts = {},
    },
    {
        'stevearc/overseer.nvim',
        opts = {},
    },
    {
        'Julian/lean.nvim',
        -- event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'Saghen/blink.cmp',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            mappings = false,
            abbreviations = {
                enable = false,
            }
        }
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^6',
        lazy = false,
    },
}

