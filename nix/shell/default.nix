{pkgs ? import <nixpkgs> {}}: let
  pyEnv = pkgs.python3.withPackages (ps:
    with ps; [
      pyqt6
      pillow
      packaging
    ]);
in
  pkgs.mkShell {
    buildInputs = [
      pyEnv
      pkgs.linux-wallpaperengine
      pkgs.libxcb-cursor
    ];
  }
