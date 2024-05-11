let
  sources = import ./nix/sources.nix;

in
  {
    pkgs ? import (fetchTarball {
      url = "${sources.nixpkgs.url}";
      sha256 = "${sources.nixpkgs.sha256}";
    }) {},
    sdwirec ? sources.badgerd-sdwirec
  }:

  with pkgs;

  let
    packages = rec {
      sd-mux-ctrl = callPackage ./pkgs/sdwirec {};
    };

  in
    packages