{ stdenv, fetchgit, libftdi1, cmake, sdwirec }:

stdenv.mkDerivation rec {
  pname = "sdwirec";
  version = "1.3.0";
  src = fetchGit {
    url = "git@github.com:Badger-Embedded/badgerd-sdwirec.git";
    name = "sdwirec-sw";
    rev = "${sdwirec.rev}";
  };

  buildInputs = [
    libftdi1
    cmake
  ];

  configurePhase = ''
    mkdir build
    cmake -B build
  '';

  # change the pwd to the directory where the makefile is located
  preBuild = ''
    cd build
  '';

  # the default buildPhase executes ``make`` if a makefile is present in the pwd

  # checkPhase is skipped by default (i.e. doCheck = false)
  # sdwirec does not have a test suite, so we stick with the default

  # copy the binary to the output directory manually because ``make install``
  # assumes a standard Linux distribution (i.e. it would try to install to
  # /usr/bin or /usr/local/bin instead of $out/bin)
  installPhase = ''
    mkdir -p $out/bin
    cp build/source/sd-mux-ctrl $out/bin
  '';

  # installCheck is skipped by default (i.e. doInstallCheck = false)
  # sdwirec does not have a ``make installcheck`` target, so we stick with the
  # default
}