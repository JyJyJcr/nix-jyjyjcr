{
  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        proper = pkgs.callPackage ./proper/proper.nix { };

        shell-pkgs = [ (pkgs.texliveFull.withPackages (_: [ proper ])) ];
        zshCompEnv = pkgs.buildEnv {
          name = "zsh-comp";
          paths = shell-pkgs;
          pathsToLink = [ "/share/zsh" ];
        };
      in {
        packages.proper = proper;
        devShells.default = pkgs.mkShell rec {
          packages = shell-pkgs;
          #ZSH_COMP_FPATH = "${zshCompEnv}/share/zsh/site-functions";
        };
      });
}
