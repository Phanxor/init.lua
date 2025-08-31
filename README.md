# My Neovim configuration
This configuration requires the installation of some external programs, check `:checkhealth`.
If some things (i.e. python executable) aren't configured correctly, apply fixes in `lua/links.lua`.
The external program `tree-sitter-cli` is required for auto-installing tree-sitter parsers.
The LaTeX setup uses the PDF viewer `sioyek`,
for which you might have to set the path in `links.lua` using `vim.g.vimtex_view_sioyek_exe = /path/to/sioyek`.
Make sure to install `lua 5.1` specifically (for `luaJIT`, which Neovim uses).
For spell check, somehow this breaks the pop-up.
You can install languages using `nvim -u none` by using `:set spell` and `:set spl=en_us,nl` or similar. It should ask you to download the necessary files.

# Some markdown tests
## Python
```python
print(1)
if True:
    pass
else:
    return 1 + 1 - int('1')
```
and maybe:
## LaTeX
$$
123 + 1 
$$
And in-line: $1+1\neq 3$.
