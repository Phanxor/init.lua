-- cmp keybinds
vim.keymap.set({'i', 's'}, '<C-U>', function()
    if require('cmp').visible_docs() then
        require('cmp').scroll_docs(-10)
    end
end)
vim.keymap.set({'i', 's'}, '<C-D>', function()
    if require('cmp').visible_docs() then
        require('cmp').scroll_docs(10)
    end
end)
vim.keymap.set({'i','s'}, '<C-j>', function()
    if require('luasnip').expandable() then
        require('luasnip').expand()
    elseif not require('cmp').confirm({select=true}) then
        vim.cmd("wincmd j")
    end
end)
vim.keymap.set({'i','s'}, '<C-n>', function()
    if require('cmp').visible() then
        require('cmp').select_next_item({behavior = require('cmp').SelectBehavior.Select})
    elseif require('luasnip').locally_jumpable(1) then
        require('luasnip').jump(1)
    end
end)
vim.keymap.set({'i','s'}, '<C-p>', function()
    if require('cmp').visible() then
        require('cmp').select_prev_item({behavior = require('cmp').SelectBehavior.Select})
    elseif require('luasnip').locally_jumpable(-1) then
        require('luasnip').jump(-1)
    end
end)
vim.keymap.set({'i','s'}, '<C-Space>', function()
    local cmp = require('cmp')
    if not cmp.visible() then
        cmp.complete({reason = cmp.ContextReason.Auto})
    elseif cmp.visible_docs() then
        cmp.close_docs()
    elseif cmp.get_active_entry() ~= nil then
        cmp.open_docs()
    elseif next(cmp.get_entries()) ~= nil then
        cmp.select_next_item({behavior = require('cmp').SelectBehavior.Select})
        cmp.open_docs()
    -- else
        --print('No completion entries found.')
    end
end)
-- documentation keybinds
vim.keymap.set("i", "<C-S-k>", function() require('noice.lsp').signature() end)
vim.keymap.set("n", "<C-S-k>", function()
    vim.fn["Dasht"](vim.fn["dasht#cursor_search_terms"]())
end)


-- other keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

--- Super nice copy functionality!
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "<C-v>", "<Esc>pa")

-- Disable entering ex mode with Q
vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace current word
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- run code
vim.keymap.set("n", "<leader><CR>", "<cmd>CompilerRedo<CR>")
vim.keymap.set("n", "<leader>t<CR>", function()
    require("neotest").run.run(vim.fn.expand("%"))
end)

-- jukit keybinds
vim.keymap.set("n", "<leader>co", function() vim.fn["jukit#cells#create_below"](0) end, { desc = "Create cell below" })
vim.keymap.set("n", "<leader>cO", function() vim.fn["jukit#cells#create_above"](0) end, { desc = "Create cell above" }) -- create cell above
vim.keymap.set("n", "<leader>ct", function() vim.fn["jukit#cells#create_below"](1) end, { desc = "Create markdown cell below" })
vim.keymap.set("n", "<leader>cT", function() vim.fn["jukit#cells#create_above"](1) end, { desc = "Create markdown cell above" })
vim.keymap.set("n", "<leader>cd", function() vim.fn["jukit#cells#delete"]() end, { desc = "Delete cell" })
vim.keymap.set("n", "<leader>cm", function() vim.fn["jukit#cells#merge_below"]() end, { desc = "Merge with cell below" })
vim.keymap.set("n", "<leader>cM", function() vim.fn["jukit#cells#merge_above"]() end, { desc = "Merge with cell above" })
vim.keymap.set("n", "<leader>c<CR>", function() vim.fn["jukit#send#section"](0) end, { desc = "Run cell" })
vim.keymap.set("v", "<CR>", function() vim.fn["jukit#send#selection"]() end, { desc = "Run selection" })
vim.keymap.set("n", "<leader>cC", function() vim.fn["jukit#convert#notebook_convert"]("jupyter-notebook") end, { desc = "Convert to/from ipynb" })
vim.keymap.set("n", "<leader>cc", function()
    vim.fn["jukit#splits#output"]()
    vim.cmd('stopinsert')
    vim.b.buffhidden = "hide"
end, { desc = "Open terminal" })
vim.keymap.set("t", "c<CR>", "<BS>%jukit_run<CR>")
vim.keymap.set("t", "q<CR>", "<BS>plt.close()<CR>")

-- auto-session keybinds
-- SessionSearch
-- vim.keymap.set("n", "<leader>pp", "<cmd>SessionSearch<CR>", { desc = "Find session" })
-- LazyVim keybinds
-- Move to window using the <ctrl> hjkl keys
vim.keymap.set({"n", "i"}, "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set({"n", "i"}, "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set({"n", "i"}, "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>h", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- commenting
vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- buffers
vim.keymap.set("t", "[b", "<C-\\><C-N><cmd>BufferPrevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("t", "]b", "<C-\\><C-N><cmd>BufferNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferPrevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>BufferMovePrevious<cr>", { desc = "Move buffer left"})
vim.keymap.set("n", "<leader>bl", "<cmd>BufferMoveNext<cr>", { desc = "Move buffer right"})
vim.keymap.set("n", "<leader>bd", "<cmd>BufferClose<cr>", { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>BufferClose!<cr>", { desc = "Delete Buffer (force)" })
vim.keymap.set("n", "<leader>bu", "<cmd>BufferRestore<cr>", { desc = "Restore Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>BufferPick<cr>", { desc = "Select Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferPin<cr>", { desc = "Pin Buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferCloseAllButCurrentOrPinned<cr>", { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>bj", "<cmd>BufferGotoPinned 1<cr>", { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "Open new buffer" })
for i=1,9 do
    vim.keymap.set("n", "<C-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<cr>")
    vim.keymap.set("n", "<D-" .. i .. ">", "<cmd>BufferGoto " .. i .. "<cr>")
end

-- terminal
vim.api.nvim_set_keymap('t', '<ESC>', '<C-\\><C-n>'  , {noremap = true} )

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
vim.keymap.set("n", "<leader>gd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- Trouble
vim.keymap.set("n", "<leader>tt", function()
    require("trouble").toggle()
end)

vim.keymap.set("n", "[t", function()
    require("trouble").next({skip_groups = true, jump = true});
end)

vim.keymap.set("n", "]t", function()
    require("trouble").previous({skip_groups = true, jump = true});
end)

-- fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")

-- telescope
vim.keymap.set('n', '<leader>pf', "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set('n', '<leader>pg', "<cmd>Telescope git_files<cr>", { desc = "Find git files" })
vim.keymap.set('n', '<leader>pr', "<cmd>Telescope frecency<cr>", { desc = "Find recent files" })
vim.keymap.set('n', '<leader>pw', function()
    local word = vim.fn.expand("<cword>")
    require('telescope.builtin').grep_string({ search = word })
end, { desc = "Find selected word" })
vim.keymap.set('n', '<leader>pW', function()
    local word = vim.fn.expand("<cWORD>")
    require('telescope.builtin').grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>ps', "<cmd>Telescope live_grep<cr>", { desc = "Search within files" })
vim.keymap.set('n', '<leader>pS', "<cmd>GrugFar<cr>", { desc = "Search within files with grug-far" })
vim.keymap.set('n', '<leader>ph', "<cmd>Telescope help_tags<cr>", { desc = "Search plugin help pages" })
vim.keymap.set('n', '<leader>/', "<cmd>Telescope keymaps<cr>", { desc = "Search keybinds" })

-- which-key
vim.keymap.set('n', "<leader>q", "<cmd>wqa<cr>")
vim.keymap.set('n', "<leader><S-q>", "<cmd>qa!<cr>")
vim.keymap.set('n', "<leader>w", "<cmd>w<cr>")

-- ultisnips
-- vim.g.UltiSnipsExpandTrigger = "<Tab>"
-- vim.g.UltiSnipsJumpForwardTrigger = "ji"
-- vim.g.UltiSnipsJumpBackwardTrigger = "jp"
