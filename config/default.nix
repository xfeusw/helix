{ pkgs }: {
  # Import editor settings
  settings = import ./settings.nix;

  # Import language configurations
  languages = import ./languages.nix { inherit pkgs; };

  # Import keybindings
  keybindings = import ./keybindings.nix;

  # Import additional packages
  packages = import ./packages.nix { inherit pkgs; };

  git = import ./git.nix { inherit pkgs; };
}
