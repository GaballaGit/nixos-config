{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];

  options.spicetify.enable = lib.mkEnableOption "enable spicetify";

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;

      # colorScheme set to non-existent value: 'dawn'
      # Valid values:
      # Comfy
      # Spotify
      # Nord
      # Everforest
      # Kanagawa
      # Houjicha
      # Kitty
      # Lunar
      # Deep
      # Velvet
      # Yami
      # Hikari
      # catppuccin-latte
      # catppuccin-frappe
      # catppuccin-macchiato
      # catppuccin-mocha
      # rose-pine
      # rose-pine-moon
      # rose-pine-dawn
      # Mono
      # Sunset
      # Neon
      # Forest
      # Sakura
      # Vaporwave
      # wal16
      theme = spicePkgs.themes.comfy; #prob change this later idk if I like
      colorScheme = "catppuccin-mocha";

      enabledExtensions = with spicePkgs.extensions; [
        adblock # for when I eventually lose my student spotify lol
        hidePodcasts
        shuffle
      ];
    };
  };
}
