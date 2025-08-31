return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        opts = {
            sidebar_filetypes = { -- offset the tabline and set the titles
                ['neo-tree'] = {
                    text = 'neotree',
                    align = 'center',
                },
                undotree = {
                    text='undotree',
                    align = 'center'
                }
            },
            icons = {
                button = '󰞇', -- close icon
                diagnostics = {  -- Enables / disables diagnostic symbols
                    -- [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ''},
                },
            },
            no_name_title = ' ',
            exclude_ft = {},
            exclude_name = {},
        },
    },
    {
        'stevearc/oil.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        cond = string.sub(vim.fn.expand('%:p'), 0, 3) == 'oil',  -- this disables the Oil command (but works with oil:// uris etc)
        opts = {
            default_file_explorer = false,
            keymaps = {
                -- Neotree keymaps
                ['.'] = { 'actions.cd', mode = 'n' },
                ['<BS>'] = { 'actions.parent', mode = 'n' },
                ['<cr>'] = { 'actions.select', opts = { close = true }, mode = 'n' },
                ['H'] = { 'actions.toggle_hidden', mode = 'n' },
                ['P'] = { 'actions.preview', mode = 'n' },  -- this toggles preview
                ['R'] = { 'actions.refresh', mode = 'n' },
                ['y'] = { 'actions.yank_entry', mode = 'n' },
                ['?'] = { 'actions.show_help', mode = 'n' },
            }
        },
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        opts = {
            letter_list = 'werasdfzxcv',
            config = {
                shortcut = {
                    {
                        desc = 'New file',
                        group = 'Label',
                        key = 'n',
                        action = 'enew'
                    },
                    {
                        desc = 'Open directory',
                        group = 'Added',
                        key = 'o',
                        action = 'e .'
                    },
                    {
                        desc = 'Telescope',
                        group = 'Changed',
                        key = 't',
                        action = 'Telescope frecency'
                    },
                    {
                        desc = 'Quit',
                        group = 'Error',
                        key = 'q',
                        action = 'q'
                    }
                }
            }
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }
}
