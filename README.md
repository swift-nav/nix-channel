# WARNING
This is a **PUBLIC** repository. Contributors are advised to **NOT** commit any
sensitive information!

# Swift Nix Channel

This repository contains the Nix expressions. providing
packages used at Swift Navigation that are otherwise not available in `nixpkgs`.

## Usage

### Add the GitHub host key
To quickly add the GitHub host key to the known hosts file, run the following
command as root and answer `yes` when prompted:
```sh
$> ssh -T git@github.com
```
```plaintext
The authenticity of host 'github.com (140.82.116.4)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
```

It is OK if the command fails with the following message:
```
git@github.com: Permission denied (publickey).
```

### Adding the channel
To add the channel to a NixOS machine, run the following commands as root:
```sh
$> nix-channel --add https://github.com/swift-nav/nix-channel/archive/main.tar.gz swiftpkgs
$> nix-channel --list
$> nix-channel --update
```

The `nix-channel --update` command will download the Nix expressions from the
`main` branch of the repository and build it as a derivation. The packages will
then be available via the `<swiftpkgs>` expression.

### Using the packages
In the `configuration.nix` of the NixOS machine:
1. Import the channel and assign it to a variable.
2. Add the desired package(s) to the `environment.systemPackages` list.
```nix
let
  swiftpkgs = import <swiftpkgs> {};
in
{
  environment.systemPackages = with pkgs; [
    swiftpkgs.sd-mux-ctrl
  ];
}
```
Rebuild NixOS (`nixos-rebuild switch`) to apply the changes.

### Verify that the packages are available
To verify that the packages installed correctly, use the `which` command to
check if the executable is in the `PATH`:
```sh
$> which sd-mux-ctrl
```
```plaintext
/run/current-system/sw/bin/sd-mux-ctrl
```

## Theory of Operation
According to one [Luc Perkins](https://lucperkins.dev/blog/nix-channel/)
(paraphrased):
> Nix channels are essentially tarballs that are made available via an
> unchanging URL. Conveniently, GitHub has a built-in archive feature that
> automatically turns every branch in every GitHub repository into a tarball
> available at a URL with this structure:
> ```
> https://github.com/<username>/<repo>/archive/<branch>.tar.gz
> ```
> Therefore, it is possible to create and maintain a Nix channel without any
> additional work beyond committing and updating code in a GitHub repository.

Although the manual entry for `nix-channel --add URL [name]` claims that:
> A channel URL must point to a directory containing a file `nixexprs.tar.xz`.

In practice, the URL can point to a tarball file. The extracted contents of the
tarball need only contain a top-level `default.nix` file acting as channel's
entry point to work as intended.

Finally, the GitHub repository **MUST** be public because the
`nix-channel --update` command's download mechanism only supports HTTP Basic
Authentication at this time; therefore, it is not capable of authenticating to
GitHub in order to access a private repository.

## References
1. [Nix Pills](https://nixos.org/guides/nix-pills/)
2. [Luc Perkins' Blog "The easiest way (I've found) to create your own Nix channel"](https://lucperkins.dev/blog/nix-channel/)
3. [INRIA Nix Tutorial](https://nix-tutorial.gitlabpages.inria.fr/nix-tutorial/index.html)
4. [NixOS Manual](https://nixos.org/manual/nixpkgs/stable/)
5. [Nix Manual](https://nixos.org/manual/nix/stable/)