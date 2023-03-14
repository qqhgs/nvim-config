<h1 align="center">rynvim (/'re-wind-vim'/) WIP</h1>

<div align="center">
<img src="./assets/intro.png" alt="ryn"/>
<img src="./assets/default.png" alt="ryn"/>
<a href="https://github.com/neovim/neovim">
<img src="https://img.shields.io/badge/Neovim-0.9-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white" alt="Neovim minimum version"/>
</a>
</div>

## ⚡ Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (_Optional with manual intervention:_ See [Documentation on customizing icons](https://astronvim.com/Recipes/icons))
- Neovim 0.9+ (`Nightly` is recommended)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (_Note:_ This is only necessary if you want to use `auto_install` feature with Treesitter)
- A clipboard tool is necessary for the integration with the system clipboard (see [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) for supported solutions)
- Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using)
- Optional Requirements:
  - [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<leader>sg`)
  - [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<leader>tl`)
  - [ranger](https://github.com/ranger/ranger) - File manager terminal (`<leader>te`)

> Note when using default theme: For MacOS, the default terminal does not have true color support. You will need to use [iTerm2](https://iterm2.com/) or another [terminal emulator](https://gist.github.com/XVilka/8346728#terminal-emulators) that has true color support.
