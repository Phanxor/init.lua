return {
    {
        'rmagatti/auto-session',
        lazy = false,
        keys = { '<leader>pp', '<cmd>SessionSearch<CR>', desc = 'Session search' },
        opts = {
            suppressed_dirs = { '~/', '~/Library/CloudStorage/OneDrive-UvA/Homework/',
            '~/Downloads', '/' },
            lazy_support = true,
            auto_restore = false,
        }
    }
}
