# My Neovim configuration
This configuration requires the installation of some external programs, check `:checkhealth`.
If some things (i.e. python executable) aren't configured correctly, apply fixes in `lua/links.lua`.

The external program `tree-sitter-cli` is required for auto-installing tree-sitter parsers.
The LaTeX setup uses the PDF viewer `sioyek`.

Make sure to install `lua 5.1` specifically (for `luaJIT`, which Neovim uses).
This is required for remote plugins like `molten.nvim` (which I use to run code in Jupyter Notebooks).

This configuration somehow breaks the spell check installation pop-up.
You can install languages using `nvim -u none` by using `:set spell` and `:set spl=en_us,nl` or similar. It should ask you to download the necessary files.

For lean, make sure to install both the `lean` and `lake` binaries. One way to do so is by using `elan`, the lean version manager.

Since the Mason command `:MasonInstallAll` [does not exist](https://github.com/mason-org/mason.nvim/discussions/1618), you need to manually install some things using `:MasonInstall <thing>`
or by finding a thing in `:Mason` and installing it with `I`.
Recommendations:
- `black`
- `pyright`
- `taplo`
- `lua-language-server`
<!-- - `haskell-language-server` -->

For Haskell, install HLS, GHC and cabal using [`ghcup`](https://www.haskell.org/ghcup/), i.e. `ghcup tui`.
