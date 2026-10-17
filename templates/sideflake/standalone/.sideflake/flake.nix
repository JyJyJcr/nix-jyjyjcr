{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
    nix-jyjyjcr = {
      url = "github:jyjyjcr/nix-jyjyjcr";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      nix-jyjyjcr,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ nix-jyjyjcr.overlays.default ];
        };
      in
      {
        devShells.default = pkgs.alt-shell.mkAltShell { } {
          packages = [
          ];
        };
      }
    );
}
