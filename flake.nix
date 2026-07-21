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

    # ifykyk
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

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
        ./hosts/pyrite/configuration.nix
        inputs.home-manager.nixosModules.default

        {
          home-manager.users.gaballa = {
            imports = [
              ./modules/editors/nvf.nix
            ];
          };
        }
      ];
    };

    # My server
    #nixosConfigurations.therta = nixpkgs.lib.nixosSystem {
    # Todo
    #modules = [
    #];
    #};

    # macbook with nix darwin
    #nixosConfigurations.silver = nixpkgs.lib.nixosSystem {
    # Todo
    #modules = [
    #];
    #};
  };
}
