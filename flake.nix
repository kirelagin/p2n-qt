{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    poetry.url = "github:nix-community/poetry2nix";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, poetry }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ poetry.overlay ]; };
        inherit (pkgs) poetry2nix;
      in {
        defaultPackage = poetry2nix.mkPoetryApplication {
          projectDir = ./.;
        };
      }
    );
}
