{
  description = "ThinkPad X1 Carbon Gen 13 (Lunar Lake) Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations.thinkpad-x1c13 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/x1c13/configuration.nix
        
        nixos-hardware.nixosModules.lenovo-thinkpad-x1-13th-gen
        ({ pkgs, ... }: {
          boot.kernelPackages = pkgs.linuxPackages_latest;
          hardware.graphics = {
            enable = true;
            enable32Bit = true;
          };
        })
      ];
    };
  };
}
