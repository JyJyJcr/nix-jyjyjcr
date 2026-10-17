{
  inputs = {
    project.url = "git+file:///replace/with/project/path";
    nixpkgs.follows = "project/nixpkgs";
    flake-utils.follows = "project/flake-utils";
    nix-jyjyjcr = {
      url = "github:jyjyjcr/nix-jyjyjcr";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    {
      project,
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
          overlays = [
            nix-jyjyjcr.overlays.default
          ];
        };
      in
      {
        devShells.default = pkgs.alt-shell.alterShell project.devShells.${system}.default (
          pkgs.alt-shell.zsh-ize { }
        );
      }
    );
}
