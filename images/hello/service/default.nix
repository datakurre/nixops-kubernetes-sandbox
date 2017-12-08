{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "hello";
  src = ./main.py;
  builder = builtins.toFile "builder.sh" ''
    source $stdenv/setup
    mkdir -p $out/bin
    cp -R $src $out/bin/service
    chmod a+x $out/bin/service
    patchShebangs $out/bin/service
  '';
  propagatedBuildInputs = [
    (pkgs.python3.buildEnv.override {
      extraLibs = [
        python3Packages.aiohttp
      ];
    })
  ];
}
