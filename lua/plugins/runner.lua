return {
    {
        'phanxor/texpresso.vim',
    },
    {
        'lervag/vimtex',
        lazy = false,
    },
    {
        'rpapallas/illustrate.nvim',
        ft = {'tex', 'markdown', 'quarto', 'ipynb'},
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            text_templates = { -- Default code template for each vector type (svg/ai) and each document (tex/md)
                svg = {
                    tex = [[
                    \begin{figure}[H]
                    \centering
                    \includesvg[width=0.8\textwidth]{$FILE_PATH}
                    \caption{Caption}
                    \label{fig:}
                    \end{figure}
                    ]],
                    md = "![caption]($FILE_PATH)",
                    typ = [[
                    #figure(
                        image("$FILE_PATH", width: 80%),
                        caption: [$CAPTION]
                    ) <$LABEL>
                    ]]
                },
                ai = {
                    tex = [[
                    \begin{figure}[H]
                    \centering
                    \includegraphics[width=0.8\linewidth]{$FILE_PATH}
                    \caption{Caption}
                    \label{fig:}
                    \end{figure}
                    ]],
                    md = "![caption]($FILE_PATH)",
                    typ = [[
                    #figure(
                        image("$FILE_PATH", width: 80%),
                        caption: [$CAPTION]
                    ) <$LABEL>
                    ]]
                }
            },
        },
    },
    -- {
    --     'okuuva/auto-save.nvim',
    --     ft = { 'tex', 'bib' },
    --     cmd = { 'ASToggle' },
    --     opts = { 
    --         condition = function(buf)  -- whether or not to auto-save
    --             local ft = vim.fn.getbufvar(buf, "&filetype")
    --             if (ft == 'tex' or ft == 'bib') then
    --                 return true
    --             end
    --             return false
    --         end,
    --         trigger_events = {
    --             cancel_deferred_save = {},  -- don't cancel saves
    --             defer_save = { 'InsertLeave', 'TextChanged', 'TextChangedI' },  -- auto-save even in insert mode
    --         },
    --         debounce_delay = 1000,  -- (ms) Don't save TOO often.
    --     }
    -- },
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
    },
    {
        'Julian/lean.nvim',
        -- event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'Saghen/blink.cmp',
            'nvim-telescope/telescope.nvim',
        },
        opts = {
            mappings = false,
            abbreviations = {
                enable = false,
            }
        }
    },
    {
        'mrcjkb/haskell-tools.nvim',
        version = '^6',
        lazy = false,
    },
}

