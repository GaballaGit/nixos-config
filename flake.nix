{
	description = "My NixOS Config"; # Maybe a name later down the line when this setup grows

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};


	outputs = { nixpkgs, home-manager, ... } @ inputs: {
		nixosConfigurations.nixos= nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
			];
		};

	};
}
