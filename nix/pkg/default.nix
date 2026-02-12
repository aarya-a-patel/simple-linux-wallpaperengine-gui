{
  pkgs ? import <nixpkgs> {system = "x86_64-linux";},
  lib,
}:
pkgs.stdenv.mkDerivation rec {
  name = "simple-linux-wallpaperengine-gui";
  src = pkgs.fetchFromGitHub {
    owner = "aarya-a-patel";
    repo = "simple-linux-wallpaperengine-gui";
    rev = "2847dd47a1fe3827f08625165d42d6ddb385d7f6";
    sha256 = "sha256-dE0irLqCEngqqH7K0y+0Z3RA+vquzSesOHbX9Xf7f+g=";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  propagatedBuildInputs = with pkgs; [
    (python3.withPackages (pythonPackages:
      with pythonPackages; [
        pyqt6
        pillow
        packaging
      ]))
    linux-wallpaperengine
    libxcb-cursor
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./locales $out/bin
    install -Dm755 ./wallpaper_gui.py $out/bin/simple-linux-wallpaperengine-gui
    wrapProgram $out/bin/simple-linux-wallpaperengine-gui \
      --prefix PATH : ${lib.makeBinPath propagatedBuildInputs}
  '';

  meta = {
    description = "Simple Linux Wallpaper Engine GUI";
    homepage = "https://github.com/Maxnights/simple-linux-wallpaperengine-gui";
    # license = licenses.gpl3;
    platforms = ["x86_64-linux"];
    mainProgram = "simple-linux-wallpaperengine-gui";
  };
}
