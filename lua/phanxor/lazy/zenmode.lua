
return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>zz", function()
            require("zen-mode").setup {
                window = {
                    backdrop = 0.95,
                    width = 160,
                    options = {
                        signcolumn = "no",
                        number = false, -- disable number column
                        relativenumber = false, -- disable relative numbers
                    }
                },
                plugins = {
                    options = {
                        enabled = true,
                        laststatus = 0,
                    }
                }
            }
            require("zen-mode").toggle()
            -- vim.wo.wrap = false
            -- vim.wo.number = false
            -- vim.wo.rnu = false
            -- vim.opt.colorcolumn = "0"
            -- ColorMyPencils()
        end)
    end
}

