-- add lua/links.lua from template if it doesn't exist
Vimwiki_location = vim.fn.stdpath('data') .. '/vimwiki'  -- initialize variable
local links_file = vim.fn.stdpath('config') .. '/lua/links.lua'
local links_placeholder = vim.fn.stdpath('config') .. '/extra/links_template.lua'
if not vim.uv.fs_stat(links_file) then
    vim.uv.fs_copyfile(links_placeholder, links_file)
else
    require('links')
end

-- Load configs 1/2 (for things that need to load quickly)
require('options')
require('autocommands')

-- Install lazy if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
	vim.api.nvim_echo({
	    { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
	    { out, "WarningMsg" },
	    { "\nPress any key to exit..." },
	}, true, {})
	vim.fn.getchar()
	os.exit(1)
    end
end

-- Initialize lazy
local treesitter_path = vim.fn.stdpath("data") .. "/site"
vim.opt.rtp:prepend(treesitter_path)
vim.opt.rtp:prepend(lazypath)

-- Store plugins with configs inside ./plugins
require('lazy').setup({
    spec = {
	{ import = "plugins" },
    },
    checker = { enabled = false }, -- check for updates automatically
    change_detection = { enabled = false },
    performance = {
        disabled_plugins = { 'netrwPlugin' },
    }
})

-- Load configs 2/2
require('keybinds')
