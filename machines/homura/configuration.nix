# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configurations.nix
    #../../modules/shared
  ];

  nix.enable = false;

  networking.hostName = "homura"; # Define your hostname.

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.config.allowUnsupportedSystem = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim
    yazi
    tmux
    pi-coding-agent
  ];

  services.tailscale.enable = true;

  users.users.gaballa = {
    name = "gaballa";
    home = "/Users/gaballa";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};

    users = {
      "gaballa" = import ./home.nix;
    };
  };

  system.stateVersion = 7;
}
