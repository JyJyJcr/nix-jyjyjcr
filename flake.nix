{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    let
      #lib = { alt-shell = import ./alt-shell/alt-shell.nix; };
    in (flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        proper = pkgs.callPackage ./proper/proper.nix { };
        gnuplot-lua-tikz =
          pkgs.callPackage ./gnuplot-lua-tikz/gnuplot-lua-tikz.nix {
            gnuplotWithLua = (pkgs.gnuplot.override { withLua = true; });
          };

        alt-shell = pkgs.callPackage ./alt-shell/alt-shell.nix { };
      in {
        packages.proper = proper;
        packages.gnuplot-lua-tikz = gnuplot-lua-tikz;
        packages.alt-shell = alt-shell;

        devShells = alt-shell.mkCommonShells { } {
          packages = [
            (pkgs.texliveFull.withPackages (_: [ proper gnuplot-lua-tikz ]))
          ];
          buildInputs = [ pkgs.ghq ];
        };
      })) // {
        overlays.default = final: prev: {
          proper = prev.callPackage ./proper/proper.nix { };
          gnuplot-lua-tikz =
            prev.callPackage ./gnuplot-lua-tikz/gnuplot-lua-tikz.nix {
              gnuplotWithLua = (prev.gnuplot.override { withLua = true; });
            };
          alt-shell = prev.callPackage ./alt-shell/alt-shell.nix { };
        };
      };
}
