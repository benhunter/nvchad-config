#---
# Does not load plugins
# {
#   description = "Neovim development environment";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#
#     # flake-utils helps us build for multiple systems.
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs { inherit system; };
#
#         # Create a custom Neovim derivation that points to our repository's init.lua.
#         neovimCustom = pkgs.neovim.override {
#           configure = {
#             initVimPath = ./init.lua;
#           };
#         };
#
#         # Create a wrapped executable that launches Neovim with the writable config.
#         wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
#           #!/bin/sh
#           # Define the writable configuration directory.
#           NVIM_WRITABLE_CONFIG="$HOME/.config/nvim-dev"
#
#           # If the writable config copy does not exist, create it by copying the repository.
#           if [ ! -d "$NVIM_WRITABLE_CONFIG" ]; then
#             echo "Creating writable config copy at $NVIM_WRITABLE_CONFIG"
#             cp -r "$PWD" "$NVIM_WRITABLE_CONFIG"
#           fi
#
#           # Set XDG environment variables so Neovim reads/writes from the writable copy.
#           export XDG_CONFIG_HOME="$NVIM_WRITABLE_CONFIG"
#           export XDG_DATA_HOME="$HOME/.local/share"
#           export XDG_CACHE_HOME="$HOME/.cache"
#
#           # Launch Neovim.
#           exec ${neovimCustom}/bin/nvim -u "$NVIM_WRITABLE_CONFIG/init.lua" "$@"
#         '';
#
#       in {
#         devShells.default = pkgs.mkShell {
#           buildInputs = [ wrappedNvim ];
#
#           shellHook = ''
#             echo "Using writable Neovim config at $HOME/.config/nvim-dev"
#           '';
#         };
#
#         # Optionally, expose the custom neovim package.
#         packages.neovim = neovimCustom;
#       }
#     );
# }

#---
{
  description = "Neovim development environment. Working, loads ./init.lua, but not plugins.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # flake-utils helps us build for multiple systems.
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Override Neovim to refer to our repository's init.lua.
        neovimCustom = pkgs.neovim.override {
          configure = {
            initVimPath = ./init.lua;
          };
        };

        # Wrap nvim so it uses a writable copy of the configuration.
        wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
          #!/bin/sh
          # Define a writable configuration directory. We will use this as our full config folder.
          NVIM_WRITABLE_CONFIG="$HOME/.config/nvim-dev"

          # If the writable copy does not already exist, create it by copying the repository.
          if [ -d "$NVIM_WRITABLE_CONFIG" ]; then
            rm -rf ~/.config/nvim-dev
          fi

          echo "Creating a writable copy of the configuration at $NVIM_WRITABLE_CONFIG/nvim"
	        mkdir -p $NVIM_WRITABLE_CONFIG
          echo "Copying from $PWD to $NVIM_WRITABLE_CONFIG/nvim"
          cp -r "$PWD" "$NVIM_WRITABLE_CONFIG/nvim"

          # Set XDG variables so that Neovim uses the writable directory for all its configuration.
          export XDG_CONFIG_HOME="$NVIM_WRITABLE_CONFIG"
          export XDG_DATA_HOME="$HOME/.local/share"
          export XDG_CACHE_HOME="$HOME/.cache"

          # Launch Neovim using the configuration from the writable copy.
          exec ${neovimCustom}/bin/nvim \
            -u "$NVIM_WRITABLE_CONFIG/nvim/init.lua" \
            --cmd "set runtimepath^=$NVIM_WRITABLE_CONFIG" \
            # --cmd "lua package.path = '$NVIM_WRITABLE_CONFIG/lua/?.lua;$NVIM_WRITABLE_CONFIG/lua/?/init.lua;$NVIM_WRITABLE_CONFIG/lua/plugins/init.lua;' .. package.path" \
            "$@"
        '';
        #--cmd "print('Current package.path:', package.path)"
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ wrappedNvim ];

          shellHook = ''
            echo "NVIM_WRITABLE_CONFIG=$NVIM_WRITABLE_CONFIG"
            echo "Custom wrapped nvim is available."
            echo "Using the writable configuration at $HOME/.config/nvim-dev"
          '';
        };

        packages.neovim = neovimCustom;
      }
    );
}

#---
# {
#   description = "Neovim development environment";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#
#     # flake-utils helps us build for multiple systems.
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs { inherit system; };
#
#         # Override Neovim to refer to our repository's init.lua.
#         neovimCustom = pkgs.neovim.override {
#           configure = {
#             initVimPath = ./init.lua;
#           };
#         };
#
#         # Wrap nvim so it uses a writable copy of the configuration.
#         wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
#           #!/bin/sh
#           # Define a writable configuration directory. You might name this something like nvim-dev.
#           NVIM_WRITABLE_CONFIG="$HOME/.config/nvim-dev"
#
#           # Copy the repository (configuration source) to the writable directory if it doesn't exist.
#           if [ ! -d "$NVIM_WRITABLE_CONFIG" ]; then
#             echo "Creating a writable copy of the configuration at $NVIM_WRITABLE_CONFIG"
#             cp -r "$PWD" "$NVIM_WRITABLE_CONFIG"
#           fi
#
#           # Use the writable configuration and standard data and cache directories.
#           export XDG_CONFIG_HOME="$HOME/.config"
#           export XDG_DATA_HOME="$HOME/.local/share"
#           export XDG_CACHE_HOME="$HOME/.cache"
#
#           # Symlink the writable config into XDG_CONFIG_HOME as nvim
#           ln -snf "$NVIM_WRITABLE_CONFIG" "$XDG_CONFIG_HOME/nvim"
#
#           # Launch Neovim using the configuration from the writable copy.
#           #exec ${neovimCustom}/bin/nvim "$@"
# 	  exec ${neovimCustom}/bin/nvim -u "$HOME/.config/nvim-dev/init.lua" --cmd "set runtimepath^=$HOME/.config/nvim-dev" "$@"
#         '';
#       in {
#         devShells.default = pkgs.mkShell {
#           buildInputs = [ wrappedNvim ];
#
#           shellHook = ''
#             echo "Custom wrapped nvim is available. It uses a writable configuration copy at $HOME/.config/nvim-dev"
#           '';
#         };
#
#         packages.neovim = neovimCustom;
#       }
#     );
# }

#---
# {
#   description = "Neovim development environment";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#
#     # flake-utils helps us build for multiple systems.
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs { inherit system; };
#
#         # Our custom Neovim derivation remains the same.
#         neovimCustom = pkgs.neovim.override {
#           configure = {
#             initVimPath = ./init.lua;
#           };
#         };
#
#         # We create a wrapped nvim executable which uses a writable config copy.
#         wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
#           #!/bin/sh
#           # Use the writable directory for config (nvim-dev) and use the repository for source.
#           # First, copy the repository to $HOME if the writable folder doesn't exist.
#           if [ ! -d "$HOME/.config/nvim-dev" ]; then
#             echo "Copying configuration to a writable location..."
#             cp -r "$PWD" "$HOME/.config/nvim-dev"
#           fi
#           export XDG_CONFIG_HOME="$HOME/.config"
#           # Call neovim with our writable configuration directory.
#           exec ${neovimCustom}/bin/nvim -u "$HOME/.config/nvim-dev/init.lua" --cmd "set runtimepath^=$HOME/.config/nvim-dev" "$@"
#         '';
#       in {
#         devShells.default = pkgs.mkShell {
#           buildInputs = [ wrappedNvim ];
#
#           shellHook = ''
#             echo "Custom wrapped nvim is available."
#             echo "It uses a writable copy of the config in $HOME/.config/nvim-dev."
#           '';
#         };
#
#         packages.neovim = neovimCustom;
#       }
#     );
# }

#---
# {
#   description = "Neovim development environment";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#
#     # flake-utils helps us build for multiple systems.
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs { inherit system; };
#
#         # Our custom Neovim: we still override it to refer to our local init.lua.
#         neovimCustom = pkgs.neovim.override {
#           configure = {
#             initVimPath = ./init.lua;
#           };
#         };
#
#         # Create a wrapped version of nvim that tells Neovim where to find its config.
#         wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
#           #!/bin/sh
#           #
#           # This wrapper forces Neovim to use the repository's init.lua file
#           # and prepends the repository directory to 'runtimepath' so that
#           # the entire repository (including the "lua" directory) is available.
#           exec ${neovimCustom}/bin/nvim \
#             -u "$PWD/init.lua" \
#             --cmd "set runtimepath^=$PWD" \
#             "$@"
#         '';
#       in {
#         devShells.default = pkgs.mkShell {
#           buildInputs = [ wrappedNvim ];
#
#           shellHook = ''
#             echo "Custom wrapped nvim is available. It uses the repository's init.lua and includes the entire repo in 'runtimepath'."
#           '';
#         };
#
#         packages.neovim = neovimCustom;
#       }
#     );
# }

#---
# {
#   description = "Neovim development environment";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
#
#     # flake-utils helps us build for multiple systems.
#     flake-utils.url = "github:numtide/flake-utils";
#   };
#
#   outputs = { self, nixpkgs, flake-utils }:
#     flake-utils.lib.eachDefaultSystem (system:
#       let
#         pkgs = import nixpkgs { inherit system; };
#
#         # Override the default Neovim derivation.
#         # We provide the local init.lua from the repository root so that Neovim starts up with your configuration.
#         neovimCustom = pkgs.neovim.override {
#           configure = {
#             # Point Neovim to your local init.lua file.
#             initVimPath = ./init.lua;
#           };
#         };
#
#       in {
#         devShells.default = pkgs.mkShell {
#           # Build inputs include your custom neovim.
#           buildInputs = [ neovimCustom ];
#
#           # The shellHook ensures that Neovim sees this repository as its configuration directory.
#           # It does this by setting XDG_CONFIG_HOME to the current directory and linking the repo as "nvim" inside it.
#           shellHook = ''
#             echo "Setting up Neovim configuration..."
#
# 	    export NVIM_APPNAME=nvim-dev
#
#             # Set the config home to the current repository so that, by default,
#             # Neovim will look into $XDG_CONFIG_HOME/nvim for its configuration.
#             #export XDG_CONFIG_HOME="$PWD"
#             # Ensure that $XDG_CONFIG_HOME/nvim exists and points to the repository.
#             ln -snf "$PWD" "$XDG_CONFIG_HOME/nvim-dev"
#             ln -snf "$PWD" "$XDG_CONFIG_HOME/nvim"
#             echo "Configured Neovim to use $PWD as its configuration directory."
#           '';
#         };
#
#         # Optionally, expose the custom Neovim package as an output.
#         packages.neovim = neovimCustom;
#       }
#     );
# }
