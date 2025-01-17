return {
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
            require('telescope').setup({
                defaults = {
                    -- Your regular Telescope's options.
                    mappings = {
                        n = {
                            ["<Insert>"] = require('telescope.actions').close
                        }
                    }
                },
                extensions = {
                    frecency = {
                        auto_validate = false,
                        path_display = { "filename_first" },
                        hide_current_buffer = true,
                        ignore_register = function(bufnr)
                            return vim.bo[bufnr].filetype == "help"
                        end,
                        show_scores = true,
                    },
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            })
            require('telescope').load_extension('fzf')
            require("telescope").load_extension("frecency")
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release' ..
        '&& cmake --build build --config Release'
    },
    {
        "nvim-telescope/telescope-frecency.nvim",
    }
}

