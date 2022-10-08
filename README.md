# requirements
1. nodejs
2. neovim 0.8+
3. lazygit -- awesome termial ui for git
4. ncdu -- list file by size
5. htop -- an interactive process viewer
6. python3

# optional dependencies
1. prettier -- js/ts formatter
2. black -- python formatter
3. stylua -- lua formatter
4. clang_format -- c/c++ formatter
5. eslint -- additional js/ts diagnostic it can work with tsserver lsp,  so its ok
6. fortune -- show a random quotation from a collection of quotes in alpha dashboard

# Install

```shell
git clone https://github.com/nfwyst/enviroment.git ~/.config/nvim
```

# Use

0. run `:checkhealth` in command mode to check nvim enviroment is ok, you can install missing dependencies by check it
1. run `:PackerInstall` in command mode to install all plugins
2. run `:LspInstallInfo` in command mode to install language server protocol manually, it give us language specific completion and diagnostic
3. run `:TSInstall` in command mode to install treesitter, it give us a tons of context syntax highlight support, indent, folds, etc...

# Todo

- testing integrating
- debug integrating
