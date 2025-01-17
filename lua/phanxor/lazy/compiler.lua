return {
    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
        opts = {}
    },
    {
        "stevearc/overseer.nvim",
        -- commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            strategy = "jobstart",
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail = 1,
                bindings = {
                    ["?"] = "ShowHelp",
                    ["g?"] = "ShowHelp",
                    ["<CR>"] = "RunAction",
                    ["k"] = "PrevTask",
                    ["j"] = "NextTask",
                    ["<C-u>"] = "ScrollOutputUp",
                    ["<C-d>"] = "ScrollOutputDown",
                    ["q"] = "Close",
                    ["dd"] = "Dispose",
                    ["<C-e>"] = false,
                    ["o"] = false,
                    ["<C-v>"] = false,
                    ["<C-s>"] = false,
                    ["<C-f>"] = false,
                    ["<C-q>"] = false,
                    ["p"] = false,
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["L"] = false,
                    ["H"] = false,
                    ["["] = false,
                    ["]"] = false,
                    ["{"] = false,
                    ["}"] = false,
                    ["<C-k>"] = false,
                    ["<C-j>"] = false,
                },
            },
        },
    },
    {
        "luk400/vim-jukit",
    },
    -- {
    --     "chomosuke/term-edit.nvim",
    --     event = "TermOpen",
    --     setup = function()
    --         require('term-edit').setup({
    --             prompt_end = '❯ ',
    --             use_up_down_arrows = function()
    --                 return false
    --             end,
    --         })
    --     end
    -- },
    -- {
    --     "mfussenegger/nvim-dap-python",
    --     setup = function()
    --         require("dap-python").setup("python3")
    --     end
    -- },
    -- {
    --     "mfussenegger/nvim-dap",
    --     setup = function()
    --         require('dap').configurations.python = {
    --             {
    --                 -- The first three options are required by nvim-dap
    --                 type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    --                 request = 'launch';
    --                 name = "Launch file";
    --             },
    --         }
    --     end
    -- },
    -- {
    --     "nvim-neotest/neotest",
    --     dependencies = {
    --         "nvim-neotest/nvim-nio",
    --         "nvim-lua/plenary.nvim",
    --         "antoinemadec/FixCursorHold.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --         "nvim-neotest/neotest-python"
    --     },
    --     config = function()
    --         require("neotest").setup({
    --             adapters = {
    --                 require("neotest-python")({
    --                     -- dap = { justmycode = false },
    --                 })
    --             }
    --         })
    --     end
    -- }
}
