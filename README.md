# Neovim Configuration

Holds configuration files for my custom neovim configuration. I originally started off with a [fork](https://github.com/cbmorrell/kickstart-modular.nvim) of `kickstart.nvim`, but have since moved to my own configuration.


## Tools
- `lazy.nvim`: plugin manager
- `mason.nvim`: install LSP handlers (e.g., pyright)

Lockfiles are kept in `lockfiles` so you can keep track of different files for different systems. You can restore your plugins to those versions using `:Lazy restore`. When you generate a new lockfile, copy it to this directory. That way you have the current config as `lazy-lock.json` and a backup in `lockfiles`.

See the `lazy.nvim` [documentation](https://lazy.folke.io/usage#-commands) for a list of the commands. Here are the main ones you need to know:

- `:Lazy install`: Installs missing plugins.
- `:Lazy clean`: Cleans plugins that are no longer needed.
- `:Lazy update`: Update plugins to newer versions (from online). This updates the lockfile to these new versions.
- `:Lazy sync`: Run `install`, `clean`, and `update`.
- `:Lazy restore`: Restore plugins to the state in the lockfile.

## Troubleshooting

Here are some notes when installing on a new system.

- Make sure all plugins are installed by calling `:Lazy` and syncing all plugins.
- Will have to reinstall `debugpy` python venv based on your OS (if using `debugpy`).
- Live grep requires `ripgrep`, which is a command line tool you need to install system wide (not just a nvim dependency).
- Node has to be >= v14 for `pyright` to work. If it isn't, it may not work and mention `node` errors in the lsp-log. `nvm` is a useful way to [manage multiple node versions](https://github.com/nvm-sh/nvm).

