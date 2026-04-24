{
  description = "My NixOS Config"; # Maybe a name later down the line when this setup grows

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim
    nvf.url = "github:notashelf/nvf";

    # ifykyk
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    aagl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/default/configuration.nix
        ./modules/programs/aagl.nix # as far as I know, home manager is not supported for this yet, hence its here
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
  };
}
