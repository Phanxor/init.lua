local ls = require('luasnip')
local extras = require('luasnip.extras')
local s, t, i, f, sn, c, d = ls.s, ls.t, ls.i, ls.f, ls.sn, ls.c, ls.d
local snippets = {}
local autosnippets = {}
local add = function(arg) vim.list_extend(autosnippets, { arg }) end
local add_manual = function(arg) vim.list_extend(snippets, { arg }) end
add_manual(s('for', {
    t('for (int '), i(1, 'i'), t('='), i(2, '0'), t('; '),
    f(function(args) return args[1][1] end, {1}),
    t('<'),
    i(3, 'n'),
    t('; ++'),
    f(function(args) return args[1][1] end, {1}),
    t({ ') {', '    ' }),
    i(4),
    t({ '', '}', '' }),
    i(0),
}))
return snippets, autosnippets
