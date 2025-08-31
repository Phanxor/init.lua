return {
    {
        'GCBallesteros/jupytext.nvim',
        config = true,
        opts = {
            notebook_extension = 'ipynb',
            style = 'quarto',
            output_extension = 'qmd',
            force_ft = 'quarto',
        },
    },
    {
        'benlubas/molten-nvim',
        build = ':UpdateRemotePlugins',
        ft = { 'markdown', 'quarto' },  -- idk I don't use quarto (yet?)
        -- cmd = { 'MoltenInit' },
        dependencies = { '3rd/image.nvim' },
    },
    {
        "quarto-dev/quarto-nvim",
        ft = { "quarto", "markdown", "ipynb" },
        dependencies = {
            "jmbuhr/otter.nvim",
            'benlubas/molten-nvim',
        },
        opts = {
            lspFeatures = {
                enabled = 'false'
            },
            codeRunner = {
                enabled = true,
                default_method = "molten", -- "molten", "slime", "iron" or <function>
                -- ft_runners = { python="molten" }, -- filetype to runner, ie. `{ python = "molten" }`.
                -- Takes precedence over `default_method`
                never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
            },
        },
    },
}
