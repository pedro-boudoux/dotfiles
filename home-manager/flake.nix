# flake.nix
{
  description = "Pedro's Home Manager Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };
    
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    obsidian-nvim.url = "github:epwalsh/obsidian.nvim";

    nvf = {
	url = "github:NotAShelf/nvf";
	inputs.nixpkgs.follows = "nixpkgs";
#	inputs.obsidian-nvim.follows = "obsidian-nvim";
    };
    
  };


  outputs = inputs@{ self, nixpkgs, home-manager, nvf, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."pedro" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs; };
        modules = [
	  nvf.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
