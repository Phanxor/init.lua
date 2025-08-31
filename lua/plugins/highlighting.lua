local image_exts = {
            "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.png",
            "*.svg", "*.tiff", "*.webp", "*.bmp"
}
return {
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        lazy = false,
        opts = {
            dim_inactive = true,
            options = {
                modules = {
                    barbar = true
                }
            },
            groups = {
                carbonfox = {
                    BufferCurrent = { bg = '#000000' },
                    BufferCurrentMod = { bg = '#000000' },
                    BufferCurrentSign = { bg = '#000000' },
                }
            }
        },
        init = function()
            vim.cmd("colorscheme carbonfox")
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',  -- Note: it's built-in, but useful for installing.
        branch = 'main',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter').install({ 'python', 'latex', 'regex', 'bash', 'yaml', 'lua' }):wait(300000)  -- wait max. 5 minutes for installing the defaults
            -- NOTE: this requires tree-sitter-cli (and an internet connection)
        end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = { 'markdown', 'quarto' },
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        opts = {
            html = {
                enabled = true,
                render_modes = true
            },
            latex = {
                enabled = false,
            },
            win_options = {
                conceallevel = {
                    rendered = 2
                }
            },
        },
    },
    {
        '3rd/image.nvim',
        -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/1210
        event = 'BufReadPre ' .. table.concat(image_exts, ','),
        build = false, -- because we're using magick_cli
        opts = {
            max_height = 12,
            max_height_window_percentage = math.huge, -- this is necessary for a good experience
            max_width_window_percentage = math.huge,
            markdown = {
                filetypes = { 'markdown', 'ipynb', 'quarto' },
            },
            html = {
                enabled = true,
                filetypes = { 'html', 'htm', 'xhtml', 'php', 'markdown' },
            },
            hijack_file_patterns = image_exts,
        },
    },
}
