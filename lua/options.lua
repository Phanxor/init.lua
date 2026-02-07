vim.g.mapleader = ' '
vim.g.maplocalleader = ' '  -- I don't want this to be different

vim.o.modeline = true  -- modelines are cool
vim.o.autochdir = false  -- Don't set pwd based on file (i.e. for terminals).
vim.o.clipboard = "unnamedplus"  -- use system clipboard
------------- Line numbers ------------------
vim.o.number = true
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'  -- shows the current line in color
-- I don't want relative numbers since that's too changes too often
vim.o.mousescroll = 'ver:1,hor:1'  -- slower mouse scrolling (so I don't get lost)
vim.o.mousemodel = 'popup'  -- don't change cursor position with right click

------------- Search options ----------------
vim.o.hlsearch = false  -- idk I don't like search highlights
vim.o.ignorecase = true  -- ignoring case probably works fine

------------ Indentation options ------------
vim.o.expandtab = true  -- use spaces
vim.o.shiftwidth = 4    -- use this number of spaces
vim.o.autoindent = true -- on new lines too

------------ Completion options ------------- (probably irrelevant due to nvim-cmp)
vim.o.complete = "., w, b, u, t"  -- default, scans current buffer, windows, other buffers (loaded and unloaded) and tags.
vim.o.completeitemalign = "abbr, kind, menu"  -- sort order
vim.o.completeopt = "fuzzy,noinsert,menu,menuone"  -- matching type

------------ Spelling options ---------------
vim.o.spelllang = 'en_us,nl'
vim.o.spell = false
----------  Plugin related options ----------
-- vimwiki
vim.g.vimwiki_map_prefix = '<leader>v'

vim.g.vimwiki_list = {{
    path=Vimwiki_location .. '/wiki',
    path_html=Vimwiki_location .. '/export/html'
}}
-- gx
vim.g.netrw_nogx = true
-- barbar
vim.g.barbar_auto_setup = false
-- statusline
vim.o.laststatus = 3  -- one statusline
-- undotree
vim.o.undofile = true
vim.o.showcmdloc = 'statusline'
-- neotree
vim.g.loaded_netrw = 1 -- disable netrw according to https://github.com/nvim-neo-tree/neo-tree.nvim/issues/943#issuecomment-1561250600
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- diagnostic colors
vim.diagnostic.config({
    signs = {
        text = {  -- disable the diagnostics before the line numbers
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
        numhl = {  -- color the line numbers
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
    }
})
-- lsp
-- https://www.reddit.com/r/neovim/comments/18yj2mu/how_to_properly_configure_lua_ls/
vim.lsp.config('lua-ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'require' }
            },
        }
    }
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'matlab',
  callback = function()
    vim.lsp.start({
            cmd = {
                '/Users/gebruiker/.local/share/nvim/mason/bin/matlab-language-server',
                '--stdio'
            },
            filetypes = { 'matlab' },
            root_dir = function(fname)
                return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
            end,
            single_file_support = false,
            settings = {
                MATLAB = {
                    indexWorkspace = false,
                    installPath = '/Applications/MATLAB_R2025b.app',
                    matlabConnectionTiming = 'onStart',
                    telemetry = false,
                },
            },
        })
  end,
})
vim.lsp.config('pyright', {
    root_dir = function(bufnr, on_dir)  -- pyright seems to spit out some error otherwise
        on_dir(vim.fn.getcwd())
    end,
})
vim.lsp.enable('digestif')  -- installed externally
-- vim.lsp.enable('ccls')  -- installed externally
-- vim.lsp.config('ccls', {
--   init_options = {
--     cache = {
--       directory = ".ccls-cache";
--     };
--   }
-- })
vim.lsp.config('ruff', {
    lint = {
        select = {
            -- pycodestyle
            "E",
            -- Pyflakes
            "F",
            -- pyupgrade
            "UP",
            -- flake8-bugbear
            "B",
            -- flake8-simplify
            "SIM",
            -- isort
            "I",
        }
        -- select = "ALL",
    },
    format = {
        quote_style = 'single'
    }
})
vim.lsp.config('ltex_plus', {
    settings = {
        ltex = {
            -- diagnosticsSeverity = 'warning',
            additionalRules = {
                motherTongue = 'nl'
            },
            checkFrequency = 'save',  -- occurs less often than on EVERY edit
            latex = {
                commands = {
                    ['\\title{}'] = 'ignore',
                    ['\\incfig{}'] = 'ignore',
                    ['\\listofkeytheorems[]'] = 'ignore',
                },
            }
        }
    }
})
--
-- vim.lsp.config('clangd', {
--
-- })
vim.lsp.enable('clangd')
vim.lsp.enable('ruff')
-- linting (ALE)
vim.g.ale_set_loclist = false
vim.g.ale_echo_cursor = false  -- no proximity
vim.g.ale_set_balloons = false
vim.g.ale_python_ruff_options = '--preview --cache-dir=' .. vim.fn.stdpath('state') .. '/ruff/'
vim.g.ale_set_quickfix = false  -- use quickfix list for warnings etc
vim.g.ale_set_loclist = true
vim.g.ale_echo_cursor = false
vim.g.ale_virtualtext_cursor = 'disabled'
vim.g.ale_disable_lsp = false
vim.g.ale_lint_on_text_changed = true
vim.g.ale_linters = {
    python = { 'ruff' },
}
vim.g.ale_linters_explicit = true  -- only run specified linters
vim.g.ale_fixers = { python = { 'ruff' } }  -- used on :ALEFix

-- debug adapter
-- change diagnostics to show ghost text but not underline
vim.diagnostic.config({
    underline = false,
    -- virtual_text = false,
    -- virtual_lines = true, -- might be too long (toggle this on to see errors more clearly)
    virtual_text = true, -- temp
    virtual_lines = false,
    severity_sort = true,
    update_in_insert = true,  -- This is kind of necessary when using virtual lines, because otherwise
                              -- lots of (diagnostic) lines will disappear when entering insert mode.
})
vim.diagnostic.enable()
---------------- vimtex ---------------------
vim.g.vimtex_view_method = 'sioyek'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_compiler_latexmk_engines = { _='-lualatex' }
vim.g.vimtex_compiler_latexmk = {
    aux_dir = vim.fn.stdpath('state') .. '/latexmk',  -- just store every aux file in one folder (it's temporary anyways)
    options = {
        '-verbose',
        '-file-line-error',
        '-synctex=1', -- the defaults, apparently
        '-interaction=nonstopmode',
        -- '-f'  -- force compilation (maybe this'll fix the error popups?)
        '-e \'$max_repeat=20\''
    }
}
-- vim.g.vimtex_view_automatic = 0  -- this disables automatically opening the pdf view
vim.g.vimtex_complete_enabled = 0  -- use LSP instead of vimtex
vim.g.vimtex_doc_enabled = 0  -- don't open pdf docs using 'K' (because this is usually a very general latex documentation) (texdoc is default) (for now)
-- TODO: Maybe textodite? 
vim.g.vimtex_fold_bib_enabled = 1
vim.g.vimtex_indent_enabled = 0
-- vim.g.vimtex_syntax_enabled = 1
-- vim.g.tex_conceal = 'amg'  -- conceal accents, symbols and greek characters.
vim.g.vimtex_syntax_conceal = {
    accents=1,
    ligatures=1,
    greek=1,
    cites=1,
    fancy=0,
    spacing=0,
    math_bounds=0,
    math_delimiters=0,
    math_fracs=0,
    math_super_sub=0,
    math_symbols=1,
    sections=0,
    styles=1,
    texTabularChar=0,
}

vim.g.vimtex_syntax_custom_cmds = {
    {name='R', cmdre='R>', mathmode=1, concealchar='ℝ'},
    {name='C', cmdre='C>', mathmode=1, concealchar='ℂ'},
    {name='N', cmdre='N>', mathmode=1, concealchar='ℕ'},
    {name='Q', cmdre='Q>', mathmode=1, concealchar='ℚ'},
    {name='Z', cmdre='Z>', mathmode=1, concealchar='ℤ'},
    {name='P', cmdre='P>', mathmode=1, concealchar='ℙ'},
    {name='limits', cmdre='limits>', mathmode=1, concealchar='.'},
    {name='mid', cmdre='Mid>', mathmode=1, concealchar='│'},
    {name='lvert', cmdre='lvert> ', mathmode=1, concealchar='|'},
    {name='rvert', cmdre='rvert>', mathmode=1, concealchar='|'},
    {name='lVert', cmdre='lVert> ', mathmode=1, concealchar='‖'},
    {name='rVert', cmdre='rVert>', mathmode=1, concealchar='‖'},
    {name='left_brace', cmdre='\\{', mathmode=1, concealchar='{'},
    {name='right_brace', cmdre='\\}', mathmode=1, concealchar='}'},
    {name='left', cmdre='left>', mathmode=1, concealchar='.'},
    {name='right', cmdre='right>', mathmode=1, concealchar='.'},
}
vim.g.vimtex_env_toggle_math_map = {
    ['$']='\\[',
    ['\\[']='align*',
    ['align*']='\\[',
}
vim.g.vimtex_doc_handlers = {'vimtex#doc#handlers#texdoc'}
vim.g.vimtex_doc_confirm_single = false
-- Using texpresso for continuous compilation now.
-- vim.g.vimtex_quickfix_open_on_warning = false
-- vim.g.vimtex_quickfix_autojump = false
-- vim.g.vimtex_quickfix_enabled = false
-- vim.g.vimtex_quickfix_mode = 0
-- vim.g.vimtex_compiler_silent = true
-- vim.g.vimtex_subfile_start_local = true  -- fixes preamble as the mainfile.
-- more options in autocommands.lua

-- molten
vim.g.molten_image_provider = 'image.nvim'
vim.g.molten_wrap_output = true
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_output_win_max_height = 20
