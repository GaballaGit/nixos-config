# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ../../modules/nixos
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "therta"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los-Angeles";

  users.users.gaballa = {
    isNormalUser = true;
    extraGroups = ["wheel"]; 
    packages = with pkgs; [
      tree
    ];
    initialPassword = "123";
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    tailscale
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };


  services.tailscale.enable = true;
  networking.firewall.allowedUDPPorts = [ 41641 ]; # tailscale needs this port for wireguard, which is a vpn from what I understand.

  system.stateVersion = "25.11"; 
}
