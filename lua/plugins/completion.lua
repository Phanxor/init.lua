return {
    {
        'saghen/blink.cmp',
        version = '*',
        dependencies = {
            'L3MON4D3/LuaSnip',
        },
        ---@module "blink.cmp"
        ---@type blink.cmp.Config
        opts = {
            keymap = { preset = 'none' },
            cmdline = {
                keymap = { preset = 'none' },
                completion = { menu = { auto_show = true } },
            },
            appearance = {
                nerd_font_variant = 'mono'
            },
            sources = {
                default = {
                    'lsp', 'path', 'snippets'  -- Don't add buffer.
                },
                per_filetype = {
                    lua = { inherit_defaults = true, 'lazydev' }
                },
                providers = {
                    lazydev = {  -- for @module autocomplete
                        name = 'LazyDev',
                        module = 'lazydev.integrations.blink',
                        score_offset = 100,
                    },
                    snippets = {
                        opts = {
                            show_autosnippets = false,  -- TODO: think of whether or not I should enable this.
                        },
                    }
                },
            },
            signature = { enabled = true },
            snippets = {
                preset = 'luasnip',
            },
            completion = {
                -- documentation = {
                --     auto_show = true,  -- false by default
                --     auto_show_delay_ms = 0,
                -- },
                ghost_text = { enabled = true },
                keyword = { range = 'full' },
                list = {
                    selection = {
                        preselect = true, auto_insert = false
                    }
                },
                menu = {
                    draw = {
                        columns = {
                            { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' }
                        },
                    },
                },
            }
        },
    },
    {
        'L3MON4D3/LuaSnip',
        build = 'make install_jsregexp',
        opts = function()
            require('luasnip.loaders.from_vscode').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
            require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
            -- https://github.com/L3MON4D3/LuaSnip/issues/830
            local auto_expand = require("luasnip").expand_auto
            require('luasnip').expand_auto = function()
                vim.o.undolevels = vim.o.undolevels  -- triggers undo save
                auto_expand()
            end
            return {
                enable_autosnippets = true,
                update_events = 'TextChanged,TextChangedI',  -- update more often, according to documentation
                ft_func = require('luasnip.extras.filetype_functions').from_cursor_pos,
            }
        end,
    },
    {
        'chrisgrieser/nvim-scissors',
        cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' },
        lazy = true,
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
            jsonFormatter = 'jq',  -- for formatted snippet files
        },
    },
    {
        'dense-analysis/ale',
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {},
        dependencies = {
            'neovim/nvim-lspconfig',  -- auto configure lsps
            'mason-org/mason.nvim'
        }
    },
    {
        'mason-org/mason.nvim',
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            },
            ensure_installed = {
                'black',
                'pyright',
                'taplo',
                'lua_ls',
                'hls'
            }
        }
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '{3rd}/luv/library', words = { 'vim%.uv' } },  -- Only enable uv when vim.uv is found. (from documentation)
            },
        }
    },
}
