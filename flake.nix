{
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  }:
    nixpkgs.lib.mergeAttrsList [
      (utils.lib.eachDefaultSystem
        (
          system: let
            pkgs = import nixpkgs {
              inherit system;
              config.allowBroken = true;
            };
          in {
            packages.default = pkgs.callPackage ./nix/pkg {};
            devShells.default = pkgs.callPackage ./nix/shell {};
          }
        ))
      {
        homeManagerModules.default = import ./nix/home-manager-module self;
      }
    ];
}
