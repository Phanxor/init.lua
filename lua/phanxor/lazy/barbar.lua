return {
    priority = 100,
    lazy = false,
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    opts = {
        sidebar_filetypes = {
            ['neo-tree'] = {event = 'BufWipeout', text = 'Filesystem' },
            ['undotree'] = {event = 'BufWipeout', text = 'UndoTree' },
            Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
        },
        icons = {
            -- Configure the base icons on the bufferline.
            button = '󰞇',
            -- Enables / disables diagnostic symbols
            diagnostics = {
                [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ''},
                [vim.diagnostic.severity.WARN] = {enabled = false},
                [vim.diagnostic.severity.INFO] = {enabled = false},
                [vim.diagnostic.severity.HINT] = {enabled = true},
            },
        },
        no_name_title = " ",
        exclude_ft = {},
        exclude_name = {},
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
        -- …etc.
    },
}
