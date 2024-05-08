# Swift Nix Channel

This repository contains the Nix expressions / derivations / etc. providing
packages used within Swift NixOS machines, conveniently bundled as a Nix channel.

## Usage
PLACEHOLDER

## Theory of Operation
According to one [Luc Perkins](https://lucperkins.dev/blog/nix-channel/)
(paraphrased):
> Nix channels are essentially tarballs that are made available via an
> unchanging URL. Conveniently, GitHub has a built-in archive feature that
> automatically > turns every branch in every GitHub repository into a tarball
> available at a URL with this structure:
> ```
> https://github.com/<username>/<repo>/archive/<branch>.tar.gz
> ```
> Therefore, it is possible to create and maintain a Nix channel without any
> additional work beyond committing and updating code in a GitHub repository.

## References
1. [Nix Pills](https://nixos.org/guides/nix-pills/)
2. [Luc Perkins' Blog "The easiest way (I've found) to create your own Nix channel"](https://lucperkins.dev/blog/nix-channel/)
3. [INRIA Nix Tutorial](https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/index.html)
4. [NixOS Manual](https://nixos.org/manual/nixpkgs/stable/)

## Other
We could choose to submit these packages to the
[Nixpkgs repository](https://github.com/NixOS/nixpkgs) in the future.