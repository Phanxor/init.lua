return {
    {
        "kylechui/nvim-surround", -- essential for changing surrounding envs
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
            })
        end
    },
    "roobert/surround-ui.nvim", -- add it to which-key
}
