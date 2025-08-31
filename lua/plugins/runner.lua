return {
    {
        'lervag/vimtex',
        lazy = false,
    },
    {
        'okuuva/auto-save.nvim',
        ft = { 'tex', 'bib' },
        cmd = { 'ASToggle' },
        opts = {
            condition = function(buf)  -- whether or not to auto-save
                local ft = vim.fn.getbufvar(buf, "&filetype")
                if (ft == 'tex' or ft == 'bib') then
                    return true
                end
                return false
            end,
            trigger_events = {
                cancel_deferred_save = {},  -- don't cancel saves
                defer_save = { 'InsertLeave', 'TextChanged', 'TextChangedI' },  -- auto-save even in insert mode
            },
            debounce_delay = 500,  -- (ms) Don't save TOO often.
        }
    },
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
    }
}

