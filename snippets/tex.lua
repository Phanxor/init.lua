-- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#api-1
local ls = require('luasnip')
local extras = require('luasnip.extras')
local s, t, i, f, sn, c, d = ls.s, ls.t, ls.i, ls.f, ls.sn, ls.c, ls.d
local isn, rep, nonempty, ai = ls.indent_snippet_node, extras.rep, extras.nonempty, require('luasnip.nodes.absolute_indexer')
local snippets = {}
local autosnippets = {}
local fmt = function(str) return '\\' .. str .. ' ' end
local is_not_command = function()
    -- Source for current word finder: https://vi.stackexchange.com/a/31091
    local word = vim.fn.matchstr(vim.fn.getline('.'), '\\S*\\%' .. vim.fn.virtcol('.') .. 'v\\S*')
    local _, backslash = string.find(word, '\\')
    if not backslash then return true end
    local last = 0
    local _, bracket = string.find(word, '{')
    local _, space = string.find(word, '')
    local _, bracket2 = string.find(word, '}')
    last = math.max(last, bracket or 0, bracket2 or 0, space or 0)
    return backslash > last
end
local is_math = function()
    if vim.o.filetype == 'markdown' or vim.o.filetype == 'quarto' then
        if not is_not_command() then return false end
        return true  -- enable functions when not in .tex file (still broken though)
    end
    if not is_not_command() then return false end
    if vim.fn['vimtex#syntax#in_mathzone']() == 1 then return true end
    local pos = vim.fn['vimtex#env#is_inside']('tabular')
    if pos[1] ~= 0 then return true end  -- note that line 0 is impossible to reach
    return false
end
local is_not_math = function()
    if vim.o.filetype == 'markdown' or vim.o.filetype == 'quarto' then
        return false  -- disable normal mode functions when not in .tex file
    end
    if not is_not_command() then return false end  -- somehow this breaks OFTEN
    if vim.fn['vimtex#syntax#in_mathzone']() == 1 then return false end
    local pos = vim.fn['vimtex#env#is_inside']('tabular')
    if pos[1] ~= 0 then return false end
    return true
end
local add = function(arg) vim.list_extend(autosnippets, { arg }) end
local add_manual = function(arg) vim.list_extend(snippets, { arg }) end

local sm = function(context, nodes, opts)
    if type(context) == 'string' then
        context = { trig=context }
    end
    context = vim.tbl_extend('keep', context, {
        condition = is_math,
        show_condition = is_math,
        wordTrig = false,
    })
    opts = opts or {}
    return s(context, nodes, opts)
end

local snm = function(context, nodes, opts)
    if type(context) == 'string' then
        context = { trig=context }
    end
    context = vim.tbl_extend('keep', context, {
        condition = is_not_math,
        show_condition = is_not_math,
        wordTrig = false,
    })
    opts = opts or {}
    return s(context, nodes, opts)
end


-- if true then  -- for testing
--     return snippets, autosnippets
-- end
---------------------------- Bindings ---------------------------
for _, val in ipairs({
    'ge', 'le', 'neq', 'iff', 'circ', 'pm', 'mp', 'bm', 'times', 'sup',
    'sin', 'cos', 'tan', 'cot', 'sec', 'csc',
    'quad', 'chi', 'eta', 'mu', 'nu', 'phi', 'pi', 'psi', 'rho',
    'tau', 'cup', 'cap', 'det', 'dim', 'not', 'mod', 'gcd', 'ln', 'log',
    'min', 'max', 'neg', 'tr', 'lcd'
}) do
    add(sm({trig=val, priority=999}, t(fmt(val))))
end
-- different value result
for key, val in pairs({
    ['*']='cdot',
    con='contra',
    asin='arcsin',
    acos='arccos',
    atan='arctan',
    col='colon',
    qq='qquad',
    dis='displaystyle',
    hn='N', hz='Z', hc='C', hp='P', hk='K', ho='emptyset', hr='R', hP='powerset', hi='I',
    opl='oplus',
    opm='otimes',
    app='approx',
    inf='infty',
    inv='inf',
    inn='in',
    ldo='ldots',
    cdo='cdots',
    mto='mapsto',
    mfr='mapsfrom',
    ato='to',
    afr='gets',
    ito='implies',
    ifr='impliedby',
    alp='alpha',
    bet='beta',
    del='delta',
    eps='epsilon',
    gam='gamma',
    iot='iota',
    kap='kappa',
    lam='lambda',
    omg='omega',
    ome='omega',
    sig='sigma',
    the='theta',
    ups='upsilon',
    xii='xi',  -- too confusing with x * i
    zet='zeta',
    ddd='Delta',
    ggg='Gamma',
    lll='Lambda',
    ooo='Omega',
    ppp='Phi', -- I don't wanna use Pi, because it's too similar to \prod
    sub='subset',
    sps='supset',
    bup='bigcup',  -- first letter shenanigans
    bap='bigcap',
    pow='powerset',  -- custom command for this ig (I want \P for probability).
    equ='equiv',
    ['and']='land',
    ['or']='lor',
    thf='therefore',
    ang='angle',
    tri='triangle',
    mid='mid',
    Mid='Mid',
}) do
    add(sm(key, t(fmt(val))))
end
-- functions with curly brackets: -------
for key, val in pairs({
    bold='textbf',
    emph='emph'
}) do
    add(snm(key, {t('\\' .. val .. '{'), i(1), t('}'), i(0)}))
end

for key, val in pairs({
    sqrt='sqrt',
    tt='text',
    oli='overline',  -- no ordered lists in math mode anyways
    vec='bm',
    bm='bm',
    vct='vec',
    pha='hphantom',
}) do
    add(sm(key, {t('\\' .. val .. '{'), i(1), t('} '), i(0)}))
end
-- bkt { }
-- sqrt, pp (^)
-- sum, int
add(sm('sum', {
    t('\\sum_{'), i(1, 'k'), t('='), i(2, '0'), t('}^{'), i(3), t('} '), i(0)
}))
add(sm('prod', {
    t('\\prod_{'), i(1, 'k'), t('='), i(2, '0'), t('}^{'), i(3), t('} '), i(0)
}))
add(sm('int', {
    t('\\int\\limits_{'), i(1), t('}^{'), i(2), t('} '), i(4), t(' \\d{'), i(3), t('} '), i(0)
}))
add(sm({trig='iint', priority=1001}, {
    t('\\iint\\limits_{'), i(1), t('}^{'), i(2), t('} '), i(4), t(' \\d{'), i(3), t('} '), i(0)
}))
add(sm({trig='iiint', priority=1002}, {
    t('\\iiint\\limits_{'), i(1), t('}^{'), i(2), t('} '), i(4), t(' \\d{'), i(3), t('} '), i(0)
}))
-- limits
add(sm({ trig='([%a])lim', trigEngine='pattern', priority=1001 }, {
    t('\\lim_{'), f(function(_, snip) return snip.captures[1] end), t('\\to\\infty} ')
}))
add(sm({trig='slim', priority=1002}, t('\\limsup ')))
add(sm({trig='ilim', priority=1002}, t('\\liminf ')))
add(sm('lim', { t('\\lim_{'), i(1), t('\\to '), i(2), t('} '), i(0) }))
-- magic functions: ------------------
-- math environments
add(snm({trig='mm', wordTrig=true}, {t('$'), i(1), t('$'), i(0)}))
local toggle_math = {f(function()
    vim.fn['vimtex#env#toggle_math']()  -- swap around math modes (direct is not important)
    return ''
end)}
add(sm({trig='mm', wordTrig=true}, f(function()
    vim.cmd.normal('f$')
    return ''
end)))
add(snm('prf', { t({'\\begin{proof}', ''}), i(0), t({'', '\\end{proof}', ''}) }))
add_manual(snm('?', {
    t('\\begin{ex}{'), i(1),
    t({'}\\ \\\\', ''}), i(0),
    t({'', '\\end{ex}', '\\begin{sol}\\ \\\\', '', '\\end{sol}'}) }))
add(sm({trig='nn', wordTrig=true}, toggle_math))
add(snm({trig='nn', wordTrig=true}, {
    isn(1, f(function()
        if vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win())[2] > 0 then
            return {'', ''}  -- add newline if not at the start of a line
        end
        return ''
    end), ''),
    isn(2, t({'\\[', ''}), ''),
    i(1, '.'),  -- add static text to not cause errors when compiling
    isn(3, t({'', '\\]', ''}), ''),
    i(0)
}))
--   (letter)(number): letter_number
add(sm({ trig='([%a])([%d])', trigEngine='pattern' }, f(function(_, snip)
    return snip.captures[1] .. '_' .. snip.captures[2]
end)))
-- multiple numbers: letter_numbernumber to letter_{numbernumber}
add(sm({ trig='_([%d][%d])', trigEngine='pattern' }, {
    t('_{'),
    f(function(_, snip) return snip.captures[1] end),
    i(1),
    t('} '),
    i(0)
}))
--   p(number): ^(number) (high priority than p_(number))
add(sm({ trig='p([%d])', trigEngine='pattern', priority=1001 }, f(function(_, snip)
    return '^' .. snip.captures[1]
end)))
add(sm('pp', {t('^{'), i(1), t('} '), i(0)}))
--   § for general brackets
add(sm('§', {t('{'), i(1), t('} '), i(0)}))
--   pp for superscript
add(sm('pp', {t('^{'), i(1), t('} '), i(0)}))
--   oo for subscript
add(sm('oo', {t('_{'), i(1), t('} '), i(0)}))
add(snm('\\usep', {
    t('\\usepackage'),
    nonempty(2, '[', ''),
    i(2),  -- only add brackets if this has any value
    nonempty(2, ']', ''),
    t('{'), i(1), t('}')
}))
add(snm('fig', {
    t({'\\begin{figure}[H]', ''}),
    i(1),
    t({'', '\\caption{'}),
    i(2),
    t({'}', '\\end{figure}', ''})
}))
add(snm('img', {t('\\includegraphics[width='), i(0, '0.4\\linewidth'), t(']{'), i(1), t('}')}))
add(snm('tkz', {
    t({'\\begin{tikzpicture}', ''}),
    i(0),
    t({'', '\\end{tikzpicture}'}),
}))
-- 'recursive' dynamic snippet. Expands to some text followed by itself.
-- Source: https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua#L73
local rec_item
rec_item = function()
    return sn(
        nil,
        c(1, {
            -- Order is important, sn(...) first would cause infinite loop of expansion.
            t(""),
            sn(nil, { t({ "", "\\item " }), i(1), d(2, rec_item, {}) }),
        })
    )
end
add(snm("uli", {
    t({ "\\begin{itemize}", "\\item " }),
    i(1),
    d(2, rec_item, {}),
    t({ "", "\\end{itemize}" }),
}))
add(snm("ali", {
    t({ "\\begin{enumerate}[label=(\\alph*)]", "\\item " }),
    i(1),
    d(2, rec_item, {}),
    t({ "", "\\end{enumerate}" }),
}))
add(snm("oli", {
    t({ "\\begin{enumerate}", "\\item " }),
    i(1),
    d(2, rec_item, {}),
    t({ "", "\\end{enumerate}" }),
}))
local matrix_cell
matrix_cell = function(args, _, _, user_args)
    local columns = tonumber(args[1][1]) or 2
    local cur_column = user_args + 1
    local text_sep
    if cur_column > columns then
        cur_column = 1
        text_sep = { ' \\\\', '' }
    else
        text_sep = ' & '
    end
    return sn(nil, {
        t(text_sep),
        i(1),
        c(2, {
            t(''),
            d(nil, matrix_cell, {ai(1)}, { user_args = { cur_column }}),
        })
    })
end
add(sm('mat', {
    t('\\begin{bmatrix}  % columns: '),
    i(1),
    t({'', ''}),
    i(2),
    c(3, {
        t(''),
        d(nil, matrix_cell, {ai(1)}, { user_args = { 1 }})
    }),
    t({'', '\\end{bmatrix}', ''}),
}))
add(sm({ trig='smat', priority=1001 }, {
    t('\\begin{bsmallmatrix}  % columns: '),
    i(1),
    t({'', ''}),
    i(2),
    c(3, {
        t(''),
        d(nil, matrix_cell, {ai(1)}, { user_args = { 1 }})
    }),
    t({'', '\\end{bsmallmatrix}', ''}),
}))
add(sm({ trig='dmat', priority=1001 }, {
    t('\\begin{vmatrix}  % columns: '),
    i(1),
    t({'', ''}),
    i(2),
    c(3, {
        t(''),
        d(nil, matrix_cell, {ai(1)}, { user_args = { 1 }})
    }),
    t({'', '\\end{vmatrix}', ''}),
}))
local next_table_stop
next_table_stop = function(args, _, _, user_args)
    local columns = tonumber(args[1][1]) or 2
    local cur_column = user_args + 1
    local text_sep
    if cur_column > columns then
        cur_column = 1
        text_sep = { ' \\\\', '' }
    else
        text_sep = ' & '
    end
    return sn(nil, {
        t(text_sep),
        i(1),
        c(2, {
            t(''),
            d(nil, next_table_stop, {ai(1)}, { user_args = { cur_column }}),
        })
    })
end
add(s({ trig='tab', condition=require('luasnip.extras.conditions.expand').line_begin, show_condition=require('luasnip.extras.conditions.expand').line_begin}, {
    t({'\\begin{table}[H]', '\\begin{tabular}{*{'}),
    i(1),
    t({'}{d{2}}}', '\\toprule', ''}),
    d(2, function(args)
        local columns = tonumber(args[1][1]) or 2
        local headers = { t('\\header{'), i(1), t('}')}
        for j = 2, columns, 1 do
            vim.list_extend(headers, {
                t(' & \\header{'), i(j), t('}')
            })
        end
        vim.list_extend(headers, {t(' \\\\')})
        return sn(nil, headers)
    end, {1}),
    t({'', '\\midrule', ''}),
    i(3),
    c(4, {
        t(''),
        d(nil, next_table_stop, {ai(1)}, { user_args = { 1 }})  -- ?????????
    }),
    t({'', '\\\\ \\bottomrule', '\\end{tabular}', '\\end{table}', ''}),
    i(0)
}))

add(sm({ trig = '([%d]+)/', trigEngine='pattern' }, {
    t('\\frac{'),
    f(function(_, snip) return snip.captures[1] end),
    t('}{'),
    i(1),
    t('} '),
    i(0)
}))
add(sm({ trig = '(%b())/', trigEngine='pattern' }, {
    t('\\frac{'),
    f(function(_, snip)
        local cap = snip.captures[1]
        return string.sub(cap, 2, string.len(cap)-1)  -- remove the outer parentheses
    end),
    t('}{'),
    i(1),
    t('} '),
    i(0)
}))
add(sm('//', {
    t('\\frac{'),
    i(1),
    t('}{'),
    i(2),
    t('} '),
    i(0)
}))
local new_line
new_line = function()
    return sn(nil, {
        t({' \\\\', ''}),
        i(1),
        c(2, {
            t(''),
            d(2, new_line),
        })
    })
end
add(sm('cas', {
    t({'\\begin{cases}', ''}), i(1), c(2, {t(''), d(nil, new_line) }), t({'', '\\end{cases}'})
}))
add(sm('deg', t('^\\circ ')))
add(sm('lrb', {t('\\left\\{'), i(1), t('\\right\\} '), i(0)}))
add(sm('ver', {t('\\lvert '), i(1), t('\\rvert '), i(0)}))
add(sm('Ver', {t('\\lVert '), i(1), t('\\rVert '), i(0)}))
add(sm('bin', {t('\\binom{'), i(1), t('}{'), i(2), t('} '), i(0)}))
add(sm('ceil', {t('\\lceil '), i(1), t('\\rceil'), i(0)}))
add(sm('flr', {t('\\lfloor '), i(1), t('\\rfloor'), i(0)}))
-- derivatives (usually partial, except low dimensions)
add(sm({trig='d([%a])d([%a])', trigEngine='pattern'}, {
    t('\\frac{\\partial{'),
    f(function(_, snip) return snip.captures[1] end),
    t('}}{\\partial{'),
    f(function(_, snip) return snip.captures[2] end),
    t('}} ')
}))
local partial_cd
partial_cd = function(_, snip, user_args)
    -- t('\\frac{\\partial^{'),
    -- f(function(_, snip) return snip.captures[1] end),
    -- t('}{'),
    -- f(function(_, snip) return snip.captures[2] end),
    -- t('}}{'),
    -- d()
    return ''
end
add(sm({trig='d_(%d+)([%a])D([%a])', trigEngine='pattern'}, {
    t('\\frac{\\d['),
    f(function(_, snip) return snip.captures[1] end),
    t(']{'),
    f(function(_, snip) return snip.captures[2] end),
    t('}}{\\d{'),
    f(function(_, snip) return snip.captures[3] end),
    t('}^{'),
    f(function(_, snip) return snip.captures[1] end),
    t('}} '),
}))
add(snm({trig=',,(.)', trigEngine='pattern'}, {
    t('$'), f(function(_, snip) return snip.captures[1] end), t('$')
}))
add(sm({trig='d([%a])D([%a])', trigEngine='pattern'}, {
    t('\\frac{\\d{'),
    f(function(_, snip) return snip.captures[1] end),
    t('}}{\\d{'),
    f(function(_, snip) return snip.captures[2] end),
    t('}} ')
}))
add(sm('exi', {f(function()
    if vim.fn.virtcol('.') == 1 then
        return ''
    else
        return '\\,'
    end
end), t('\\exists ')}))
add(sm({trig='for', priority=1001}, {f(function()
    if vim.fn.virtcol('.') == 1 then
        return ''
    else
        return '\\,'
    end
end), t('\\forall ')}))
add(sm('fal', {f(function()
    if vim.fn.virtcol('.') == 1 then
        return ''
    else
        return '\\,'
    end
end), t('\\forall ')}))
add(snm('fnc', { t({
    '\\begin{tikzpicture}[domain=-5:5]',
'\\draw[very thin,color=gray] (-5,-5) grid (5, 5);',
'\\draw[->] (-5.2,0) -- (5.2,0) node[right] {$x$};',
'\\draw[->] (0,-5.2) -- (0,5.2) node[above] {$y$};',
'\\draw[color=blue] plot[id=x] (\\x,'
}), i(1), t({');', '\\end{tikzpicture}', ''}), i(0)
}))
-- TODO: proofs, theorems, homework questions etc.
-- add(sm('/', {t('/'), f(function() vim.fn['vimtex#cmd#toggle_frac']() end)})) -- this is too bad
-- (because it throws the cursor to the start of the line) (tsf works but has the same issues)
return snippets, autosnippets
