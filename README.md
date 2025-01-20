# NvChad Config

Starter config for NvChad

# Nixos

On `nixos` branch.

## nix develop

Best with `direnv` from https://github.com/nix-community/nix-direnv. See `.envrc`.

## Update lazy lock file

```
cp ~/.config/nvim-dev/nvim/lazy-lock.json .
```

# Troubleshooting

## Reset cache for clean start

```
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

# Original README

**This repo is supposed to used as config by NvChad users!**

- The main nvchad repo (NvChad/NvChad) is used as a plugin by this repo.
- So you just import its modules , like `require "nvchad.options" , require "nvchad.mappings"`
- So you can delete the .git from this repo ( when you clone it locally ) or fork it :)

# Credits

1) Lazyvim starter https://github.com/LazyVim/starter as nvchad's starter was inspired by Lazyvim's . It made a lot of things easier!
