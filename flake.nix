{
  description = "NixOS Atena - Estudos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.venus =
        nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            
            ./builds

          ];
        };
    };
}