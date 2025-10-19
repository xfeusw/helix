# Helix Editor Nix Flake

This repository provides a Nix flake for configuring the Helix editor, which can be used as an input in a NixOS Home Manager setup.

## Prerequisites

- NixOS with `nix flakes` enabled
- Home Manager installed and configured

## Usage

1. **Add this flake as an input** in your Home Manager configuration (`home.nix` or equivalent):

   ```nix
   inputs = {
     helix-config = {
       url = "github:xfeusw/helix";
       inputs.nixpkgs.follows = "nixpkgs";
     };
   };
   ```

2. **Integrate the flake** into your Home Manager configuration:

   ```nix
   home-manager.users.<your-username> = { pkgs, inputs, ... }: {
     imports = [ inputs.helix-config.homeManagerModules.default ];
   };
   ```

3. **Apply the configuration**:

   ```bash
   nix flake update
   home-manager switch
   ```

## Flake Structure

- `flake.nix`: Main flake definition, specifying inputs and outputs.
- `flake.lock`: Locks dependencies to specific versions.
- `config/`: Contains modular configuration files for Helix:
  - `default.nix`: Entry point for Home Manager module.
  - `settings.nix`: General Helix editor settings.
  - `keybindings.nix`: Custom keybindings.
  - `languages.nix`: Language-specific configurations.
  - `git.nix`: Git integration settings.
  - `packages.nix`: Additional packages for Helix.

## Customization

- Modify files in `config/` to tailor Helix settings (e.g., `settings.nix` for editor behavior, `keybindings.nix` for keymaps).
- Update `flake.nix` to include additional inputs or modify outputs if needed.
- Run `nix flake update` to refresh dependencies after changes.

## Notes

- Ensure your NixOS system has the necessary permissions to access the repository.
