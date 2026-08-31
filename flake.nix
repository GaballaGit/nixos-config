{
  description = "My NixOS Config"; # Maybe a name later down the line when this setup grows

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Soon
    #nix-darwin = {
    #  url = "github:LnL7/nix-darwin";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    # Neovim
    nvf.url = "github:notashelf/nvf";

    # spicetify
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # ifykyk
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # consider using stylix for theming later
    #stylix = {
    #  url = "github:nix-community/stylix";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.mizuki = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/mizuki/configuration.nix
        inputs.home-manager.nixosModules.default
        {
          home-manager.users.gaballa = {
            imports = [
              ./modules/editors/nvf.nix
              ./modules/home/noctalia.nix
            ];
          };
        }
      ];
    };

    # My server
    nixosConfigurations.therta = nixpkgs.lib.nixosSystem {
      # Todo
      specialArgs = {inherit inputs;};
      modules = [
        ./machines/therta/configuration.nix
      ];
    };

    # macbook with nix darwin
    #nixosConfigurations.homura = nixpkgs.lib.nixosSystem {
    # Todo
    #modules = [
    #];
    #};
  };
}
