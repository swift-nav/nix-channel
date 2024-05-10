{ pkgs }:

stdenv.mkDerivation {
  pname = "sdwirec";
  version = "1.3.0";
  src = ./.;
  buildInputs = [ pkgs.my-dependency ];
}