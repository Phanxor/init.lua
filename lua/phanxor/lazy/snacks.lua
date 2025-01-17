return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            dashboard = { enabled = true },
            bigfile = { enabled = true },
            -- notifier = { enabled = false },
            quickfile = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            bufdelete = { enabled = true }
        },
        dependencies = {
            { "echasnovski/mini.icons" },
            { "nvim-tree/nvim-web-devicons" },
            { "folke/persistence.nvim" }
        },
    }
}
