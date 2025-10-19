{
  description = "Helix editor configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix.url = "github:helix-editor/helix";
  };

  outputs = {
    self,
    nixpkgs,
    helix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    # Import all configurations from default.nix
    helixConfig = import ./config {inherit pkgs;};
  in {
    # Home-manager module
    homeManagerModules.default = {
      config,
      lib,
      pkgs,
      ...
    }: {
      programs.helix = {
        enable = true;
        package = helix.packages.${system}.default;

        # Import settings
        settings = helixConfig.settings;

        # Import languages configuration
        languages = helixConfig.languages;

        # Import keybindings
        settings.keys = helixConfig.keybindings;
      };

      # Add additional packages needed for Helix
      home.packages = helixConfig.packages;
    };

    # For testing/development
    packages.${system}.default = helix.packages.${system}.default;

    # Expose configurations for reuse or inspection
    lib = {
      inherit (helixConfig) settings languages keybindings packages;
    };
  };
}
