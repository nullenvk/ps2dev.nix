{
  description = "PS2 homebrew development toolchain";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [

      ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {

        packages = {
          dvp-binutils = pkgs.callPackage ./pkgs/dvp-binutils {}; 
          iop-binutils = pkgs.callPackage ./pkgs/iop-binutils {};
          ee-binutils = pkgs.callPackage ./pkgs/ee-binutils {};

          ee-stage1-gcc = pkgs.callPackage ./pkgs/ee-stage1-gcc {};
        };

        devShells.default = pkgs.mkShell {
          nativeBuildInputs = [ 
            self'.packages.dvp-binutils
            self'.packages.iop-binutils
          ];
        };

        devShells.ee-stage1 = pkgs.mkShell {
          nativeBuildInputs = [
            self'.packages.ee-stage1-gcc
            self'.packages.ee-binutils
          ];
        };
      };
      flake = {

      };
    };
}
