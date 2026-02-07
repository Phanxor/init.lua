return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            theme = 'auto',
            ignore_focus = { 'undotree', 'aerial', 'neo-tree', 'diff-panel' },
            component_separators = '',
            section_separators = {
                left = '',  -- this feels the wrong way around, but it's correct because it occurs in the new section.
                right = '',
            },
            globalstatus = true,
        },
        sections = {
            lualine_a = { { 'mode', separator = { left = '', right = '' } } },
            lualine_b = { {
                'filename',
                newfile_status = false,
                symbols = {
                    modified = '',
                    readonly = '',
                    unnamed = '',
                }
            }, 'branch' },
            lualine_c = { },
            lualine_x = { '%S', {
                'diagnostics',
                sources = { 'nvim_diagnostic' },  -- TODO: add trouble.nvim
            }},
            lualine_y = { 'lsp_status', 'overseer', 'filetype' },
            lualine_z = { 'selectioncount', 'location', { 'progress', separator = { left = '', right = '' } } },
        },
        -- inactive_sections = sections,
        extensions = { 'overseer', 'quickfix' },
    }
}
