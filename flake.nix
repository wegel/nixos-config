{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systemConfig = {
      hostname = "gamma";
      username = "wegel";
      groups = [ "wheel" "networkmanager" "video" "docker" ];
      publicKeys = [ ];
      profile = "thin";
      arch = "x86_64-linux";
      timezone = "America/Toronto";
      locale = "en_CA.UTF-8";
    };
  in {

    overlays = import ./overlays {inherit inputs;};

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      "workstation" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs systemConfig;};
        # > Our main nixos configuration file <
        modules = [./nixos/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "workstation" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."${systemConfig.arch}"; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs systemConfig;};
        # > Our main home-manager configuration file <
        modules = [./home-manager/home.nix];
      };
    };
  };
}
