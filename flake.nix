{
  description = "ThinkPad X1 Carbon Gen 13 (Lunar Lake) Config";

  inputs = {
    nixpkgs.url = "git+https://github.com/nixos/nixpkgs?ref=nixos-unstable";
    noctalia = {
      url = "git+https://github.com/noctalia-dev/noctalia-shell?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "git+https://github.com/nix-darwin/nix-darwin?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "git+https://github.com/NixOS/nixos-hardware?ref=master";
    };
    nixos-wsl = {
      url = "git+https://github.com/nix-community/NixOS-WSL?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "git+https://github.com/nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    codex-cli-nix = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "git+https://github.com/sodiboo/niri-flake?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, noctalia, nix-darwin, nixos-hardware, nixos-wsl, home-manager, codex-cli-nix, nixvim, niri, ... }@inputs:
    let
      standaloneBaseSystem =
        if builtins ? currentSystem then
          builtins.currentSystem
        else
          throw "homeConfigurations.base requires --impure so Nix can detect the current system";

      standaloneBaseUser = builtins.getEnv "USER";
      standaloneBaseHome = builtins.getEnv "HOME";

      standaloneBaseIdentityModule =
        if standaloneBaseUser == "" || standaloneBaseHome == "" then
          throw "homeConfigurations.base requires USER and HOME to be set; run Home Manager with --impure"
        else
          {
            home.username = standaloneBaseUser;
            home.homeDirectory = standaloneBaseHome;
            home.stateVersion = "25.05";
          };
    in
    {
      homeManagerModules = {
        base = ./home/base/default.nix;
        default = ./home/default.nix;
        darwin = ./home/darwin.nix;
        gui = ./home/gui/default.nix;
      };

      homeConfigurations = {
        base = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = standaloneBaseSystem;
          };
          extraSpecialArgs = { inherit inputs; };
          modules = [
            self.homeManagerModules.base
            standaloneBaseIdentityModule
          ];
        };
      };

      nixosConfigurations = {
        studio502 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/studio502/configuration.nix
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.max = import ./hosts/studio502/home.nix;
            }
          ];
        };

        thinkpad-x1c13 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/x1c13/configuration.nix
            niri.nixosModules.niri
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.max = import ./hosts/x1c13/home.nix;
            }

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

        nixos-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/wsl/configuration.nix
            nixos-wsl.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.nixos = import ./hosts/wsl/home.nix;
            }
          ];
        };
      };

      darwinConfigurations = {
        darwin = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/darwin/configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.max = import ./hosts/darwin/home.nix;
            }
          ];
        };
      };
    };
}
