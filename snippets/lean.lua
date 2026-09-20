local ls = require('luasnip')
local s, t, i = ls.s, ls.t, ls.i
local snippets = {}
local autosnippets = {}
local add = function(arg) vim.list_extend(autosnippets, { arg }) end
local add_manual = function(arg) vim.list_extend(snippets, { arg }) end

add(s('exm', {t('example '), i(1), t(': '), i(2), t(' := by '), i(3, 'sorry'), i(0)}))
add(s('thm', {t('theorem '), i(1, 't'), t(' : '), i(2), t(' := by '), i(3, 'sorry'), i(0)}))
add(s('hv', {t('have '), i(1, 'h'), t(' : '), i(2), t(' := by '), i(3, 'sorry'), i(0)}))
add(s('pp', {t('^('), i(1), t(')'), i(0)}))

for key, val in pairs({
    fse='false',
    fal='∀ ',
    ['for']='∀ ',
    exi='∃ ',
    lll='·',
    pinv='⁻¹',
    p2='^2 ',
    p3='^3 ',
    setm=[[\]],
    dag='†',
    nab='∇',
    par='∂',
    hnn='ℕ', hzz='ℤ', hcc='ℂ', hkk='𝕂', hrr='ℝ', hPP='𝒫',
    opl='⊕',
    opm='⊗',
    apr='≈',
    gee='≥',
    lee='≤',
    inf='∞',
    inn='∈',
    notinn='∉',
    ldo='…',
    vdo='⋮',
    ddo='⋱',
    cdo='⋯',
    mto='↦',
    -- mfr='mapsfrom',
    ato='→',
    afr='←',
    ito='→',
    lan='⟨ ',
    ran='⟩',
    alp='α',
    bet='β',
    del='δ',
    eps='ε',
    gam='γ',
    iot='ι',
    kap='κ',
    lam='λ',
    ome='ω',
    psi='ψ',
    phi='φ',
    muu='μ',
    nuu='ν',
    sig='σ',
    the='θ',
    ups='υ',
    xii='ξ',  -- too confusing with x * i
    zet='ζ',
    chi='χ',
    -- Del='Delta',
    -- Gam='Gamma',
    -- Lam='Lambda',
    -- Ome='Omega',
    -- Phi='Phi', -- I don't wanna use Pi, because it's too similar to \prod
    -- The='Theta',
    subs='⊂',
    sups='⊃',
    bup='⋃',  -- first letter shenanigans
    bap='⋂',
    power='𝒫',
    equ='≃',
    iff='↔',
    ['and']='∧',
    ['orr']='∨',
    thf='∴',
    bcs='∵',
    ang='∠',
    tri='▵',
    mid='mid',
    Mid='Mid',
    eqc='≕',
    ceq='≔',
    cird='∘',
}) do
    add(s(key, t(val)))
end

return snippets, autosnippets
