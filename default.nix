let
  sources = import ./nix/sources.nix;

in
  { pkgs ? sources.nixpkgs, sdwirec ? sources.badgerd-sdwirec }:

  with pkgs;

  let
    packages = rec {
      sd-mux-ctrl = callPackage ./pkgs/sdwirec {};
    };

  in
    packages