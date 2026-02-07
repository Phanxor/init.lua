return {
    {
        'xvzc/chezmoi.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        cmd = { 'ChezmoiEdit', 'ChezmoiList' },
        lazy = true,  -- only needed in very specific situations
    },
    {
        'chrishrb/gx.nvim',
        opts = {
            handlers = {
                search = false, -- disable searching the web
            },
            select_prompt = false,
        }
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {},
        init = function()
            local Rule = require('nvim-autopairs.rule')
            local npairs = require('nvim-autopairs')
            npairs.add_rule(Rule('{', '}', '-tex'))
        end
    },
    {
        'kylechui/nvim-surround',
        event = 'VeryLazy',
        opts = {}
    },
    {
        'NeogitOrg/neogit',
        cmd = { 'Neogit' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'nvzone/minty',
        cmd = { 'Shades', 'Huefy' },
        dependencies = {
            'nvzone/volt',
        },
    },
    -- {
    --     'p00f/cphelper.nvim',
    --     cmd = { 'CphReceive', 'CphTest', 'CphRetest', 'CphEdit', 'CphDelete' },
    --     dependencies = {
    --         'nvim-lua/plenary.nvim'
    --     },
    -- }
    {
	'xeluxee/competitest.nvim',
        cmd = { 'CompetiTest' },
	dependencies = 'MunifTanjim/nui.nvim',
        opts = {
            popup_ui = {
		total_width = 0.95,
		total_height = 0.95,
            },
            companion_port = 27121,
            compile_command = {
                cpp = { exec = "g++-15", args = { "-Wall", "-O3", "$(FNAME)", "-o", "$(FNOEXT)" } },
            },
            template_file = {
                cpp = '/Users/gebruiker/.config/nvim/extra/templates/header.h',
            },
        },
    },
    {
        'vimwiki/vimwiki',
        cmd = { 'VimwikiIndex', 'VimwikiMakeDiaryNote', 'VimwikiDiaryIndex', 'VimwikiUISelect' },
        keys = {
            '<leader>vw', '<leader>vt', '<leader>vs', '<leader>vi',
            '<leader>v<leader>w', '<leader>v<leader>t', '<leader>v<leader>t',
            '<leader>v<leader>y', '<leader>v<leader>m'
        }
    },
    {
        'lambdalisue/vim-suda',
        cmd = { 'SudaWrite', 'SudaRead' }
    },
    {
        'andymass/vim-matchup',
    }
}
