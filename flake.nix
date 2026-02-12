{
  description = "Dev shell for simple-linux-wallpaperengine-gui";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};

    pyEnv = pkgs.python3.withPackages (ps:
      with ps; [
        pyqt6
        pillow
        packaging
      ]);
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = [
        pyEnv
        pkgs.libxcb-cursor
      ];
    };
  };
}
