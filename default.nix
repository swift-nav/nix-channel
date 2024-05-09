let
  sources = import ./nix/sources.nix;

in
  { pkgs ? sources.nixpkgs }:

  with pkgs;

  let
    packages = rec {
      sdwirec = callPackage ./pkgs/sdwirec {};
    };

  in
    packages