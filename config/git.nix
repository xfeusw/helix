{ pkgs }: {
  enable = true;
  package = pkgs.lazygit;
  settings = {
    # Configure lazygit for Helix integration
    lazygit = {
      enable = true;
      keybindings = {
        # Example keybindings for lazygit in Helix
        "C-g" = "lazygit";
      };
    };
  };
}
