{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    let
      #lib = { alt-shell = import ./alt-shell/alt-shell.nix; };
      overlay = final: prev: {
        proper = prev.callPackage ./proper/proper.nix { };
        gnuplot-lua-tikz = prev.callPackage ./gnuplot-lua-tikz/gnuplot-lua-tikz.nix {
          gnuplotWithLua = (prev.gnuplot.override { withLua = true; });
        };
        alt-shell = prev.callPackage ./alt-shell/alt-shell.nix { };
      };
    in
    (flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ overlay ];
        };
      in
      rec {
        packages.proper = pkgs.proper;
        packages.gnuplot-lua-tikz = pkgs.gnuplot-lua-tikz;
        packages.alt-shell = pkgs.alt-shell;

        devShells.original = pkgs.mkShell {
          packages = [
            (pkgs.texliveFull.withPackages (_: [
              pkgs.proper
              pkgs.gnuplot-lua-tikz
            ]))
          ];
          buildInputs = [ pkgs.ghq ];
        };
        devShells.default = pkgs.alt-shell.alterShell devShells.original (pkgs.alt-shell.zsh-ize { });
      }
    ))
    // {
      overlays.default = overlay;
      templates = {
        sideflake = {
          path = ./templates/sideflake;
          description = "sideflake override template";
        };
        custom = {
          path = ./templates/custom;
          description = "temporary custom project template";
        };
      };
    };
}
