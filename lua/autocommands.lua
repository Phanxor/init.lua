-- Source for some of these: https://www.reddit.com/r/neovim/comments/u9ihdt/what_are_your_favorite_autocommands/
-- disable indentation for certain file types
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"yaml", "tex"},
    callback = function()
        vim.opt.indentexpr = ""
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"lean"},
    callback = function()
        vim.opt.indentexpr = "    "
    end
})

-- Use treesitter for folding where possible.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        if ev.match == 'tex' then return true end  -- don't activate on latex files (even if latex parser is installed)
        -- if vim.treesitter.language.
        if pcall(vim.treesitter.language.inspect, ev.match) then
            pcall(vim.treesitter.start, ev.buf)
            vim.wo.foldmethod = 'expr'  -- treesitter indentation
            vim.wo.foldlevel = 99
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
        end
    end,
    desc = 'Use treesitter for folding where possible.'
})

-- Use insert mode by default for terminals
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd "startinsert!"
  end,
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType',     {
    pattern  = { 'gitcommit', 'gitrebase', },
    command  = 'startinsert | 1'})

-- -- Automatically resize window when vimtex starts compiling on macos
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "VimtexEventCompileSuccess",
--     callback = function()
--         if vim.uv.os_uname().sysname == "Darwin" then
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Ghostty\\" to set position of window 1 to {0, 25}"')
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Ghostty\\" to set size of window 1 to {804, 875}"')
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"sioyek\\" to set position of window 1 to {805, 25}"')
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"sioyek\\" to set size of window 1 to {635, 875}"')
--         end
--     end
-- })

-- -- and automatically close the viewer when done (on macos).
-- -- This doesn't work with VimtexEventQuit sadly, since that event doesn't activate.
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "VimtexEventCompileStopped",
--     callback = function()
--         if vim.loop.os_uname().sysname == "Darwin" then
--             vim.fn.jobstart('osascript -e "tell application \\"sioyek\\" to quit"')
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Ghostty\\" to set position of window 1 to {0, 25}"')
--             vim.fn.jobstart('osascript -e "tell application \\"System Events\\" to tell application process \\"Ghostty\\" to set size of window 1 to {1440, 875}"')
--         end
--     end
-- })

-- Focus the terminal after inverse search
vim.api.nvim_create_autocmd("User", {
    pattern = "VimtexEventViewReverse",
    callback = function()
        if vim.loop.os_uname().sysname == "Darwin" then
            vim.fn.jobstart('osascript -e "tell application \\"Ghostty\\" to activate"')
        else
            vim.command.call("b:vimtex.viewer.xdo_focus_vim()")
        end
    end
})

-- Return to the previous location upon opening a buffer.
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
        local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line('$')
        local not_commit = vim.b[args.buf].filetype ~= 'commit'

        if valid_line and not_commit then
            vim.cmd([[normal! g`"]])
        end
    end,
})

-- automatically start chezmoi in its folder
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*/.local/share/chezmoi/*",
    callback = function(ev)
        vim.schedule(function()
            require("chezmoi.commands.__edit").watch(ev.buf)
        end)
    end
})

-- set conceil highlight to a non-dimmed color
-- https://github.com/lervag/vimtex/issues/3171
NS_HL_TEX = vim.api.nvim_create_namespace("hl_tex")
vim.api.nvim_set_hl(NS_HL_TEX, "Conceal", { link = "texMathZone" })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex,bib",
  callback = function()
    vim.api.nvim_set_hl_ns(NS_HL_TEX)
    vim.o.conceallevel = 2  -- enable conceil too in .tex
    vim.o.concealcursor = 'ni'  -- also conceil in insert mode (visual mode unaffected), this helps with jumps in spacing.
  end,
})

-- Set the opened tex file as the main file by default.
vim.api.nvim_create_autocmd('BufReadPre', {
    pattern = '*.tex',
    callback = function(ev)
        vim.api.nvim_buf_set_var(ev.buf, 'vimtex_main', ev.match)
    end
})
-- Start texpresso compiling automatically.
vim.api.nvim_create_autocmd('User', {
    pattern = 'VimtexEventInitPost',
    callback = function(ev)
        if vim.api.nvim_buf_get_name(ev.buf):match('preamble') == nil
                and vim.api.nvim_buf_get_name(ev.buf):match('templates') == nil then
            require('texpresso')
            vim.api.nvim_exec2('TeXpresso %', {})
            -- Also open quickfix window, so errors are known!
            vim.api.nvim_exec2('copen', {})
        end
    end
})

-- help pages stuff
vim.api.nvim_create_autocmd('FileType', {
    pattern  = 'man,help',
    callback = function(ev)
        -- keybinds
        vim.keymap.set('n', '<enter>'    , 'K'    , {buffer=true})
        vim.keymap.set('n', '<backspace>', '<c-o>', {buffer=true})
        -- set buffer as listed
        vim.bo[ev.buf].buflisted = true
        vim.cmd.call("bufferline#update()")
    end
})

-- autocommand for spawning a help window
local help_windows = {}
vim.api.nvim_create_autocmd('BufWinEnter', {
    pattern = { vim.env.VIMRUNTIME .. '/doc/*', vim.fn.stdpath('data') .. '*/doc/*'},
    callback = function(ev)
        -- check if window is new
        local win = vim.api.nvim_get_current_win()
        if not vim.list_contains(help_windows, win) then
            vim.api.nvim_win_close(win, false)
            win = vim.api.nvim_get_current_win()
            vim.api.nvim_command('e ' .. ev.match)
            table.insert(help_windows, win)
        end
        -- set buffer as listed
        vim.bo[ev.buf].buflisted = true
        vim.cmd.call("bufferline#update()")
    end
})

-- When quitting, remove synctex files
-- vim.api.nvim_create_autocmd('VimLeave', {
--     -- command = ''
-- })

-- -- initialize molten
-- vim.api.nvim_create_autocmd('FileType', {
--     pattern = 'markdown,quarto',  -- somehow this executes twice, not that it matters that much
--     callback = function() vim.api.nvim_command('MoltenInit') end,
-- })

-- template insertion
local config_location = vim.fn.stdpath('config')
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = '*.tex',
    callback = function(ev)
        local template = io.open(config_location .. '/extra/templates/main.tex', 'r'):read('*a')
        local filename = ev.match:match('[^/]*$')
        local filename_no_ext = filename:match('^[^.]*')
        template = template:gsub(';F', filename)
        template = template:gsub(';f', filename_no_ext)
        template = template:gsub(';c', config_location)
        local line_iterator = template:gmatch('[^\n]+')
        local lines = {}
        local result = line_iterator()
        while result ~= nil do
            table.insert(lines, result)
            result = line_iterator()
        end
        vim.api.nvim_buf_set_lines(ev.buf, 0, -1, true, lines)
        -- vim.api.nvim_buf_set_var(ev.buf, 'vimtex_main')
        vim.b[ev.buf].vimtex_main = filename
        -- reload state? see vimtex-multi-file
        -- pcall(vim.fn.call('vimtex#compiler#compile', {}))
        -- vim.api.nvim_buf_set_text(ev.buf,  0, 0, 0, 0, { template })
    end
})
