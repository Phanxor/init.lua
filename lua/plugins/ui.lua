return {
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            lsp = {
                progress = {
                    enabled = false,
                },
                message = {
                    enabled = false,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
            },
            messages = { enabled = true }, -- somehow we need the Noice messages ui for fidget
            notify = { enabled = false },
            popupmenu = { backend = 'nui' },  -- default, but important option
            -- lsp = {
            --     progress = { enabled = false },
            --     signature = { enabled = false },
            --     hover = { enabled = false },
            --     override = {  -- set documentation view to markdown (for tree-sitter rendering). No clue if this gets triggered.
            --         ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            --         ['vim.lsp.util.stylize_markdown']  = true,
            --         ['cmp.entry.get_documentation'] = true
            --     }
            -- }
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
        }
    },
    {
        'j-hui/fidget.nvim',
        -- event = 'VeryLazy',
        opts = {
            notification = {
                override_vim_notify = true,
            },
            progress = {
                display = {
                    done_ttl = 0,
                },
                ignore = {
                    'ltex_plus'
                }
            }
        }
    },
    {
        'stevearc/dressing.nvim', -- for vim.ui.select (used by icon-picker.nvim)
    },
    {
        'ziontee113/icon-picker.nvim',
        cmd = { 'IconPickerYank', 'IconPickerNormal', 'IconPickerInsert' },
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            disable_legacy_commands = true
        }
    },
    {
        'jmbuhr/telescope-zotero.nvim',
        ft = { 'tex', 'bib' },
        dependencies = {
            'kkharji/sqlite.lua',
            'nvim-telescope/telescope.nvim',
        },
        -- options:
        config = function()
            require('zotero').setup({})
            require('telescope').load_extension('zotero')
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('telescope').setup({
                defaults = {
                    sorting_strategy = 'ascending',
                    layout_config = {
                        prompt_position = 'top',
                    },
                    mappings = {
                        i = {
                            ['<esc>'] = require('telescope.actions').close  -- quit on esc instead of going to normal mode
                        }
                    }
                },
            })
            require('telescope').load_extension('frecency')
            require('telescope').load_extension('fzf')
            -- require('telescope').load_extension('zotero')  -- (in telescope-zotero config)
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-frecency.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
        },
    },
}
