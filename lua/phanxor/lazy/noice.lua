return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
                -- long_message_to_split = true,
                -- inc_rename = false,
                lsp_doc_border = false
            },
            message = { enabled = false },
            lsp = {
                signature = {
                    auto_open = { enabled = false }
                },
                progress = { enabled = false }
            }
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            -- "rcarriga/nvim-notify",
        }
    }
}
