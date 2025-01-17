-- cmp background color
vim.api.nvim_set_hl(0, "CmpBackground", { bg = "#333333" })

-- fix barbar
vim.g.nvim_tree_quit_on_open = 0
vim.g.barbar_auto_setup = false

-- :h option-list
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.guicursor = ""
vim.opt.fillchars='eob: '
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.sessionoptions="buffers,curdir,folds,help," ..
"tabpages,winsize,winpos,localoptions"
vim.opt.smartindent = false
vim.g.vimtex_indent_enabled = 0

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- general
vim.o.foldenable = true
vim.o.foldmethod = "marker"
vim.o.clipboard = "unnamedplus"
vim.o.autochdir = true

-- jukit
vim.g.jukit_terminal = ''
vim.g.jukit_mappings = 0
-- vim.g.jukit_layout = -1
vim.g.jukit_layout = {
    split = 'vertical',
    p1 = 0.75,
    val = {
        'file_content',
        {
            split = 'horizontal',
            p1 = 0.6,
            val = { 'output', 'output_history' }
        }
    }
}
vim.g.jukit_highlight_markers = 0
vim.g.jukit_enable_textcell_bg_hl = 0
vim.g.jukit_in_style = 5 -- 0 to 4
vim.g.jukit_comment_mark = '# %%'
vim.g.jukit_show_prompt = 1
vim.g.jukit_mpl_block = 0


-- ale
vim.g.ale_fixers = {
    python = {'black'}
}
vim.g.ale_echo_cursor = 0

-- ultisnips
vim.g.UltiSnipsSnippetDirectories = { "ultisnips" }
vim.g.snips_author = "Phanxor"
require("phanxor.links") -- path specific settings

-- vimtex
if vim.loop.os_uname().sysname == "Darwin" then
    vim.g.vimtex_view_method = "skim"
else
    vim.g.vimtex_view_method = "zathura"
end

vim.g.vimtex_doc_handlers = { 'vimtex#doc#handlers#texdoc' }
vim.g.tex_flavor = "latex"
vim.g.vimtex_quickfix_open_on_warning = 0
vim.o.conceallevel = 0
-- vim.g.vimtex_syntax_conceal_default = 0
vim.g.vimtex_view_skim_sync = 1
vim.g.vimtex_view_skim_no_select = 1
vim.g.tex_indent_items = 0
-- vim.g.tex_indent_and = 0
vim.g.tex_indent_brace = 0
vim.g.vimtex_indent_lists = {}
vim.g.latex_indent_enabled = 0
-- vim.s.pdflatex = "pdflatex -file-line-error -interaction=nonstopmode -halt-on-error -synctex=1"
--   .. "-output-directory="
--   .. vim.fn.expand("%:r")
-- vim.s.latexmk = "latexmk -pdf -output-directory=" .. vim.fn.expand("%:r")
vim.g.vimtex_compiler_latexmk = {
    aux_dir = function()
        return vim.env.HOME .. "/.latex/" .. vim.fn.expand("%:p:h:t") .. "-" .. vim.fn.expand("%<")
    end,
    out_dir = function()
        return vim.env.HOME .. "/.latex/" .. vim.fn.expand("%:p:h:t") .. "-" .. vim.fn.expand("%<")
    end,
    options = { "-verbose", "-file-line-error", "-halt-on-error", "-interaction=nonstopmode", "-synctex=1" },
}

-- nvim-cmp
vim.o.completeopt = 'menu,menuone,noinsert'
