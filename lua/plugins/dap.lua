return {
    {
        -- source: idk
        'mfussenegger/nvim-dap',
        lazy = true,
        config = function()
            -- Signs
            for _, group in pairs({
                "DapBreakpoint",
                "DapBreakpointCondition",
                "DapBreakpointRejected",
                "DapLogPoint",
            }) do
                vim.fn.sign_define(group, { text = "●", texthl = group })
            end
            vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", numhl = "debugPC" })

            -- Setup

            -- Decides when and how to jump when stopping at a breakpoint
            -- The order matters!
            --
            -- (1) If the line with the breakpoint is visible, don't jump at all
            -- (2) If the buffer is opened in a tab, jump to it instead
            -- (3) Else, create a new tab with the buffer
            --
            -- This avoid unnecessary jumps
            require("dap").defaults.fallback.switchbuf = "usevisible,usetab,newtab"
            local dap = require('dap')
            dap.adapters.codelldb = {
              type = "executable",
              command = "codelldb",
            }
            dap.configurations.cpp = {
              {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
              },
            }


            -- Adapters
            -- Python
        end,
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
    {
        'theHamsta/nvim-dap-virtual-text',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
    },
}
