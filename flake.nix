{
  description = "Helix editor configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix";
  };

  outputs = { self, nixpkgs, helix, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      # Import all configurations from default.nix
      helixConfig = import ./config { inherit pkgs; };
    in
    {
      # Home-manager module
      homeManagerModules.default = { config, lib, pkgs, ... }: {
        options.programs.helix.installExtraPackages = lib.mkOption {
          type = lib.types.bool;
          default = true;
          description = "Whether to install extra packages (LSPs, formatters, etc.)";
        };

        config = {
          programs.helix = {
            enable = true;
            package = helix.packages.${system}.default;

            # Import settings with keybindings merged
            settings = helixConfig.settings // {
              keys = helixConfig.keybindings;
            };

            # Import languages configuration
            languages = helixConfig.languages;
          };

          # Add additional packages needed for Helix (only if enabled)
          home.packages = lib.mkIf config.programs.helix.installExtraPackages helixConfig.packages;
        };
      };

      # For testing/development
      packages.${system}.default = helix.packages.${system}.default;

      # Expose configurations for reuse or inspection
      lib = {
        inherit (helixConfig) settings languages keybindings packages;
      };
    };
}
