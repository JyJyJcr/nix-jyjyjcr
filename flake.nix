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
        gnuplot-lua-tikz =
          pkgs.callPackage ./gnuplot-lua-tikz/gnuplot-lua-tikz.nix {
            gnuplotWithLua = (pkgs.gnuplot.override { withLua = true; });
          };

        shell-pkgs =
          [ (pkgs.texliveFull.withPackages (_: [ proper gnuplot-lua-tikz ])) ];
        zshCompEnv = pkgs.buildEnv {
          name = "zsh-comp";
          paths = shell-pkgs;
          pathsToLink = [ "/share/zsh" ];
        };
      in {
        packages.proper = proper;
        packages.zshCompEnv = zshCompEnv;
        packages.gnuplot-lua-tikz = gnuplot-lua-tikz;
        devShells.default = pkgs.mkShell rec {
          packages = shell-pkgs;
          ZSH_COMP_FPATH = "${zshCompEnv}/share/zsh/site-functions";
        };
      });
}
