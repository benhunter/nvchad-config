{
  description = "Neovim development environment";

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

        # Our custom Neovim: we still override it to refer to our local init.lua.
        neovimCustom = pkgs.neovim.override {
          configure = {
            initVimPath = ./init.lua;
          };
        };

        # Create a wrapped version of nvim that tells Neovim where to find its config.
        wrappedNvim = pkgs.writeShellScriptBin "nvim" ''
          #!/bin/sh
          #
          # This wrapper forces Neovim to use the repository's init.lua file
          # and prepends the repository directory to 'runtimepath' so that
          # the entire repository (including the "lua" directory) is available.
          exec ${neovimCustom}/bin/nvim \
            -u "$PWD/init.lua" \
            --cmd "set runtimepath^=$PWD" \
            "$@"
        '';
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ wrappedNvim ];

          shellHook = ''
            echo "Custom wrapped nvim is available. It uses the repository's init.lua and includes the entire repo in 'runtimepath'."
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
