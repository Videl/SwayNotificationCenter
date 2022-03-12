{
  description = "SwayNotificationCenter";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
  utils.lib.eachDefaultSystem (system: 
  let
    pkgs = import nixpkgs { inherit system; };
  in rec {
    packages.swaync = with nixpkgs.legacyPackages.${system}; stdenv.mkDerivation {
      pname = "swaync";
      version = "1.0.0";

      src = ./.;

      nativeBuildInputs = [
        meson
        ninja
        cmake
        pkg-config
      ];

      buildInputs = [
        vala
        rubyPackages.gio2
        gtk3
        json-glib
        libhandy
        gtk-layer-shell
      ];

      outputs = [ "out" ];

      meta = with lib; {
          description = "SwayNotificationCenter";
          homepage = "https://github.com/ErikReider/SwayNotificationCenter";
          # license = licenses.lgpl21;
          platforms = platforms.unix;
        };
    };

    defaultPackage = packages.swaync;

  });
}

