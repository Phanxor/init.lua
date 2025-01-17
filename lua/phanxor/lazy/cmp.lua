return {
    {'L3MON4D3/LuaSnip'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'onsails/lspkind.nvim'},
    {
        'neovim/nvim-lspconfig',
        dependencies = { 'hrsh7th/cmp-nvim-lsp'},
        config = function()
            local lspconfig_defaults = require('lspconfig').util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
            )
        end,
    },
    {
        'williamboman/mason.nvim',
        dependencies = { 'neovim/nvim-lspconfig'},
        config = function()
            require('mason').setup({
                ui = { icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                } }
            })
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig', 'onsails/lspkind.nvim' },
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = { 'lua_ls', 'rust_analyzer', 'pyright', 'texlab' },
                handlers = {
                    function(server_name)
                        require('lspconfig')[server_name].setup({})
                    end,
                    -- example_server = function() require('lspconfig').example_server.setup({}) end,
                    lua_ls = function()
                        require('lspconfig').lua_ls.setup({
                            telemetry = { enable = false },
                            diagnostics = {
                                disable = { "missing-required-fields" },
                            },
                            runtime = {
                                version = 'LuaJIT'
                            },
                            workspace = {
                                checkThirdParty = false,
                            },
                        })
                    end,
                },
                automatic_installation = true,
            })
        end
    },
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                "LazyVim",
            }
        }
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = { 'L3MON4D3/LuaSnip', 'neovim/nvim-lspconfig' },
        config = function()
            local cmp = require('cmp')
            cmp.status()
            cmp.setup({
                performance = {
                    throttle = 0,
                    debounce = 0,
                },
                sources = {
                    { name = 'lazydev' },
                    { name = 'nvim_lsp' }
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                window = {
                    -- documentation = cmp.config.window.bordered(),
                    -- completion = cmp.config.window.bordered(),
                    completion = {
                        winhighlight = "Normal:CmpBackground",
                    }
                },
                view = {
                    docs = {
                        auto_open = false
                    }
                },
                completion = {
                    autocomplete = false
                },
                experimental = {
                    ghost_text = {
                        hl_group = 'NonText'
                    }
                },
                preselect = cmp.PreselectMode.Item,
                mapping = {}, -- This is handled in ../remap.lua
                formatting = {
                    format = require('lspkind').cmp_format(),
                },
            })
        end
    }
}
