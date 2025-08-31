return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        lazy = false,
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        ---@module 'neo-tree'
        ---@type neotree.Config
        opts = {
            filesystem = {
                -- hijack_netrw_behavior = 'open_current',
                filtered_items = {
                    visible = true,
                    hide_dotfiles = true,
                    hide_gitignored = false,
                    never_show = {  -- macos is annoying
                        '.DS_Store',
                        'thumbs.db'
                    }
                }
            },
            window = {
                width = 20,
            },
        },
    },
    {
        'stevearc/aerial.nvim',
        opts = {
            close_on_select = true
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        'mbbill/undotree',
    },
    {
        'folke/trouble.nvim',  -- more like a bottom-bar
        cmd = 'Trouble',
        opts = {
            open_no_results = false,
            warn_no_results = false,
            modes = {
                test = {
                    mode = 'diagnostics',
                    preview =  {
                        type = 'split',
                        relative = 'win',
                        position = 'right',
                        size = 0.3,
                    }
                }
            }
        },
    },
    {
        'folke/which-key.nvim',  -- idem
        event = 'VeryLazy',
        opts = {}
    },
}
