local map = vim.keymap.set

-- quicker save or quit
map('n', '<leader>q', '<cmd>wqa<cr>', {desc='Quit'})
map('n', '<leader><S-q>', '<cmd>qa!<cr>', {desc='Force quit'})
map('n', '<leader>w', '<cmd>w<cr>', {desc='Write'})

-- modify windows
map('n', '<C-Left>', '<C-W><')
map('n', '<C-Right>', '<C-W>>')
map('n', '<C-Up>', '<C-W>+')
map('n', '<C-Down>', '<C-W>-')
-- other <C-]> goto definition keybind
map('n', '<C-k>', '<C-]>')

-- make <C-BS> work
map('i', '<C-BS>', '<cmd>normal d<C-BS><cr>')
map('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')  -- fix last word's spelling
map('n', '<leader>sc', function()
    vim.api.nvim_set_option_value(
        'spell',
        not vim.api.nvim_get_option_value('spell', { scope = 'local' }),
        {scope='local'})
end, { desc = 'spell check' })
pcall(vim.api.nvim_del_keymap, 'i', '<C-u>')
map('i', '<C-u>', '<cmd>undo<cr>')  -- undo in insert mode
--------------- Visual mode keybinds ---------------
-- move lines
map('v', 'J', ":m '>+1<cr>gv=gv")
map('v', 'K', ":m '<-2<cr>gv=gv")

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')
------------ End of Visual mode keybinds -----------
---------------- Jump keybinds ---------------------
-- unbind some ]-keybinds because they're redundant (i.e. due to barbar)
pcall(vim.api.nvim_del_keymap, 'n', '[a')  -- inside pcall so sourcing is not an issue
pcall(vim.api.nvim_del_keymap, 'n', ']a')
-- vim.keymap.del('n', '[f')  -- it makes no sense for this to be equivalent to gf
-- vim.keymap.del('n', ']f')
map('n', '[t', '<cmd>tabprevious<cr>')  -- in case I spawn a tab and it's not a buffer
map('n', ']t', '<cmd>tabNext<cr>')
-- map('n', '[f', '[m')  -- functions are methods
-- map('n', ']f', ']m')
map('n', '[f', '<cmd>AerialPrev<cr>')  -- functions are methods
map('n', ']f', '<cmd>AerialNext<cr>')

-- find and replace
map('n', '<leader>ss', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', {  desc = 'Find and Replace' })  -- note the lack of <cr> (insert the hovered word in the commandline and edit it)
-------------------- Plugins -----------------------
-------------------- scissors ----------------------
map('n', '<leader>sa', '<cmd>ScissorsAddNewSnippet<cr>', { desc = 'Add snippet'})  -- Use a function for lazy loading scizzors.
map('n', '<leader>se', '<cmd>ScissorsEditSnippet<cr>', { desc = 'Edit snippet'})
------------------- barbar.nvim --------------------
require('which-key').add({{ '<leader>b', group = 'barbar' }})
map('t', '[b', '<C-\\><C-N><cmd>BufferPrevious<cr>', { desc = 'Prev Buffer' })
map('t', ']b', '<C-\\><C-N><cmd>BufferNext<cr>', { desc = 'Next Buffer' })
map('n', '[b', '<cmd>BufferPrevious<cr>', { desc = 'Prev Buffer' })
map('n', ']b', '<cmd>BufferNext<cr>', { desc = 'Next Buffer' })
map('n', '<leader>bh', '<cmd>BufferMovePrevious<cr>', { desc = 'Move buffer left'})
map('n', '<leader>bl', '<cmd>BufferMoveNext<cr>', { desc = 'Move buffer right'})
map('n', '<leader>bd', '<cmd>BufferWipeout<cr>', { desc = 'Delete Buffer' })
map('n', '<leader>bD', '<cmd>BufferWipeout!<cr>', { desc = 'Delete Buffer (force)' })
map('n', '<leader>bu', '<cmd>BufferRestore<cr>', { desc = 'Restore Buffer' })
map('n', '<leader>bb', '<cmd>BufferPick<cr>', { desc = 'Select Buffer' })
map('n', '<leader>bp', '<cmd>BufferPin<cr>', { desc = 'Pin Buffer' })
map('n', '<leader>bo', '<cmd>BufferCloseAllButCurrentOrPinned<cr>', { desc = 'Delete Other Buffers' })
map('n', '<leader>bj', '<cmd>BufferGotoPinned 1<cr>', { desc = 'Delete Other Buffers' })
map('n', '<leader>bn', '<cmd>enew<cr>', { desc = 'Open new buffer' })
for i=1,9 do
    map('n', '<C-' .. i .. '>', '<cmd>BufferGoto ' .. i .. '<cr>')
    map('n', '<D-' .. i .. '>', '<cmd>BufferGoto ' .. i .. '<cr>')
end
-------------------- gx.nvim -----------------------
map({'n', 'x'}, 'gx', '<cmd>Browse<cr>')
--------------------- sidebars ---------------------
map('n', '<leader>a', '<cmd>AerialToggle<cr>', { desc = 'Aerial' })
map('n', '<leader>u', '<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>', { desc = 'Undotree' })
map('n', '<leader>n', '<cmd>Neotree toggle<cr>', { desc = 'Neotree' })
map('n', '<leader>D', '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>', { desc = 'Diagnostics' })

-------------------- trouble (etc) (see above line) -----------------
map('n',  '<leader>f', vim.lsp.buf.code_action, {  desc = 'Quickfix' })
map('n', '<leader>d', function()
    if vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(false)
    else
        vim.diagnostic.enable(true)
    end
end, { desc = 'Diagnostics toggle' })
------------------- telescope ----------------------
require('which-key').add({{ '<leader>t', group = 'telescope' }})
require('which-key').add({{ '<leader>s', group = 'snippets/replace' }})
require('which-key').add({{ '<leader>v', group = 'vimwiki' }})
local telescope = require('telescope.builtin')
map('n', '<leader>tg', telescope.git_bcommits, { desc = 'git commits' })  -- show commits of current buffer
map('n', '<leader>tf', require('telescope').extensions.frecency.frecency, { desc = 'files' })  -- frecency
map('n', '<leader>tr', require('telescope').extensions.frecency.frecency)  -- same
require('which-key').add({{'<leader>tr', hidden = true }})
map('n', '<leader>tk', telescope.keymaps, { desc = 'keybinds' })
map('n', '<leader>ts', telescope.live_grep, { desc = 'search' })
map('n', '<leader>ti', '<cmd>IconPickerYank<cr>', { desc = 'icons' })
map('n', '<leader>th', telescope.highlights, { desc = 'highlight colors' })
map('n', '<leader>tl', require("luasnip.loaders").edit_snippet_files, { desc = 'snippets' })
map('n', '<leader>tc', function() telescope.fd({ cwd = vim.fn.stdpath('config') }) end, { desc = 'config' })
map('n', '<leader>tz', require('telescope').extensions.zotero.zotero, { desc = 'zotero' })

-- blink
local blink = require('blink.cmp')
local do_completion = function()
    blink.show()
    blink.select_and_accept()  -- somehow only one of these triggers, but at least it picks one.
end
map('i', '<Tab>', do_completion)  -- should accept snippets too
map('i', '<C-y>', do_completion)
map('c', '<Tab>', blink.accept)  -- don't execute command
map('c', '<C-y>', blink.accept)
map({'i', 'c'}, '<C-e>', blink.cancel)
map({'i', 'c'}, '<C-n>', blink.select_next)
map({'i', 'c'}, '<C-p>', blink.select_prev)
map({'i', 'c'}, '<C-Space>', function()
    if not blink.is_menu_visible() then
        blink.show_and_insert()
    elseif not blink.is_documentation_visible() then
        blink.show_documentation()
    else
        blink.hide_documentation()
    end
end)
-- compiler/overseer
-- same keymap as vimtex
map('n', '<leader>c', function() vim.lsp.codelens.run() end)
--
require('which-key').add({{ '<leader>l', group = 'run' }})
map('n', '<leader>ll', function()
    if next(require('overseer').list_tasks()) == nil then  -- check if there are no tasks saved
        vim.api.nvim_command('CompilerOpen')
    else
        vim.api.nvim_command('CompilerRedo')
    end
end)
map('n', '<leader>lt', '<cmd>terminal<cr>', { desc = 'terminal' })

-- CompetiTest
map('n', '<leader>l;', '<cmd>CompetiTest run<cr>')
-- vimtex
-- insert mode mappings are nice ('`' + letter for symbol)
-- motions are nice too (c for command, $ for math region etc)
vim.api.nvim_create_autocmd('User', {
    pattern = 'VimtexEventInitPre',
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].filetype == 'scissors-snippet' then
            return
        end
        pcall(vim.api.nvim_del_keymap, 'n', '<leader>ll')
        -- pcall(vim.api.nvim_del_keymap, 'n', '<C-k>')
        vim.keymap.set('n', '<C-k>', '<cmd>VimtexDocPackage<cr>', { buffer = true })
        -- vim.keymap.set('i', '1', function() require('luasnip').jump(1) end)  -- debug keybinds
        -- vim.keymap.set('i', '2', function() require('luasnip').change_choice(1) end)
        vim.keymap.set({'i', 's', 'n'}, ';;', function()
            local ls = require('luasnip')
            ls.jump(1)
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end)
        vim.keymap.set({'i', 's'}, '::', function() require('luasnip').jump(-1) end)
        vim.keymap.set('n', '<leader><Tab>', function() vim.fn.call('vimtex#view#view', {}) end, {buffer=true, desc = 'Focus pdf viewer'})
        require('which-key').add({{ '<leader>l', group = 'run - vimtex', buffer = true }})
    end
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'MoltenInitPost',
    callback = function()
        pcall(vim.api.nvim_del_keymap, 'n', '<leader>ll')
        vim.keymap.set('n', '<leader>ll', function() require('quarto.runner').run_cell() end,
            { desc = 'Run cell', buffer = true })
        vim.keymap.set('n', '<leader>li', function() require('quarto.runner').run_line() end,
            { desc = 'Run line', buffer = true })
        vim.keymap.set('n', '<leader>lo', '<cmd>MoltenImagePopup<cr>', { desc = 'Open image', buffer = true })
        vim.keymap.set('n', '<leader>lc', '<cmd>MoltenInterrupt<cr>', { desc = 'Stop cell', buffer = true })
        vim.keymap.set('n', '<leader>l<CR>', '<cmd>MoltenEnterOutput<cr>',
            { desc = 'Enter cell output', buffer = true })
        vim.keymap.set('n', '<leader>ld', '<cmd>MoltenDelete<cr>', { desc = 'Delete cell', buffer = true })
        vim.keymap.set('v', '<leader>ll', '<cmd>MoltenEvaluateVisual<cr>', { desc = 'Run selection', buffer = true })
        require('which-key').add({{ '<leader>l', group = 'run - molten', buffer = true }})
    end
})
-- and add the old command back
vim.api.nvim_create_autocmd('User', {
    pattern = 'MoltenDeinitPost',
    callback = function()
        vim.keymap.set('n', '<leader>ll', function()
            if next(require('overseer').list_tasks()) == nil then
                vim.api.nvim_command('CompilerOpen')
            else
                vim.api.nvim_command('CompilerRedo')
            end
        end)
    end
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lean',
    callback = function()
        pcall(vim.api.nvim_del_keymap, 'n', '<leader>ll')
        pcall(vim.api.nvim_del_keymap, 'n', '<leader>l;')
        require('which-key').add({{ '<leader>l', group='lean'}})
        map('n', '<leader>li', '<cmd>LeanInfoviewToggle<cr>', {desc='toggle infoview'})
        map('n', '<leader>lf', '<cmd>LeanInfoviewPinTogglePause<cr>', {desc='toggle freezing pins'})
        map('n', '<leader>lx', '<cmd>LeanInfoviewAddPin<cr>', {desc='add pin'})
        map('n', '<leader>lc', '<cmd>LeanInfoviewClearPins<cr>', {desc='clear pins'})
        map('n', '<leader>ldx', '<cmd>LeanInfoviewSetDiffPin<cr>', {desc='add pin (diff)'})
        map('n', '<leader>ldc', '<cmd>LeanInfoviewClearDiffPin<cr>', {desc='clear pins (diff)'})
        map('n', '<leader>ldd', '<cmd>LeanInfoviewToggleAutoDiffPin<cr>', {desc='toggle auto-diff'})
        map('n', '<leader>ldt', '<cmd>LeanInfoviewToggleAutoDiffPin<cr>', {desc='clear & toggle auto-diff'})
        map('n', '<leader>lw', '<cmd>LeanInfoviewEnableWidgets<cr>', {desc='enable widgets'})
        map('n', '<leader>lW', '<cmd>LeanInfoviewDisableWidgets<cr>', {desc='disable widgets'})
        map('n', '<leader>lv', '<cmd>LeanInfoviewViewOptions<cr>', {desc='options'})
        map('n', '<leader><tab>', '<cmd>LeanGotoInfoview<cr>', {desc='switch to info'})
        map('n', '<leader>ll', '<cmd>LeanAbbreviationsReverseLookup<cr>', {desc='look up abbreviation'})
        map('n', '<leader>lr', '<cmd>LeanRestartFile<cr>', {desc='restart'})
        map('n', '<leader>lt', '<cmd>Telescope loogle<cr>', {desc='loogle'})
    end
})

vim.api.nvim_create_autocmd('Filetype', {
    pattern='haskell',
    callback = function()
        pcall(vim.api.nvim_del_keymap, 'n', 'K')
        map('n', 'K', function() require('haskell-tools').hoogle.hoogle_signature() end, { buffer=true })
        map('n', '<leader>la', function() require('haskell-tools').lsp.buf_eval_all() end, { buffer=true })
    end
})
