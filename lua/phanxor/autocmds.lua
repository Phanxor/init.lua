-- Make help files a new buffer instead of a new window
vim.api.nvim_create_autocmd("WinNew", {
    callback = function()
        vim.schedule(function()
            if vim.bo.filetype ~="help" then
                return
            end
            -- probably fairly inefficient but it seems to work most of the time
            vim.cmd.call("bufferline#update()")
            vim.opt.buflisted = true
            vim.cmd.close()
            vim.schedule(function()
                vim.cmd.BufferLast()
                vim.opt.buflisted = true
                vim.cmd.call("bufferline#update()")
            end)
        end)
    end
})

-- disable indentation for certain file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"yaml", "tex"},
    callback = function()
        vim.opt.indentexpr = ""
    end
})

-- Automatically resize window when vimtex starts compiling
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventCompileSuccess",
    callback = function()
        if vim.loop.os_uname().sysname == "Darwin" then
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Alacritty\\" to set position of window 1 to {0, 25}"')
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Alacritty\\" to set size of window 1 to {804, 875}"')
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Skim\\" to set position of window 1 to {805, 25}"')
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Skim\\" to set size of window 1 to {635, 875}"')
        end
    end
})

-- and automatically close the viewer when done.
-- This doesn't work with VimtexEventQuit sadly, since that event doesn't activate.
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventCompileStopped",
    callback = function()
        -- print(1)
        -- vim.fn.jobstart('osascript -e "display alert \\"hi\\""')
        if vim.loop.os_uname().sysname == "Darwin" then
            vim.fn.jobstart('osascript -e "tell application \\"Skim\\" to quit"')
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Alacritty\\" to set position of window 1 to {0, 25}"')
            vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Alacritty\\" to set size of window 1 to {1440, 875}"')
        end
    end
})

-- Focus the terminal after inverse search
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventViewReverse",
    callback = function()
        if vim.loop.os_uname().sysname == "Darwin" then
            vim.fn.jobstart('osascript -e "tell application \\"Alacritty\\" to activate"')
        else
            vim.command.call("b:vimtex.viewer.xdo_focus_vim()")
        end
    end
})

vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) < vim.fn.line('$')
        local not_commit = vim.b[args.buf].filetype ~= 'commit'

        if valid_line and not_commit then
            vim.cmd([[normal! g`"]])
        end
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd "startinsert!"
  end,
})
-- autocmd('TextYankPost', {
    --     pattern = '*',
    --     callback = function()
        --         vim.highlight.on_yank({
            --             higroup = 'IncSearch',
            --             timeout = 40,
            --         })
            --     end,
            -- })
            --
            -- autocmd({"BufWritePre"}, {
                --     pattern = "*",
                --     command = [[%s/\s\+$//e]],
                -- })
                --
                -- autocmd('BufEnter', {
                    --     callback = function()
                        --         if vim.bo.filetype == "zig" then
                        --             vim.cmd.colorscheme("tokyonight-night")
                        --         else
                        --             vim.cmd.colorscheme("rose-pine-moon")
                        --         end
                        --     end
                        -- })
                        --
                        --
                        -- autocmd('LspAttach', {
                            --     callback = function(e)
                                --         local opts = { buffer = e.buf }
                                --         vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                                -- --        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                                --         vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                                --         vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                                --         vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                                --         vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                                --         vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                                --         vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                                --         vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                                --         vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                                --     end
                                -- })
