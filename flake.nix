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

        packages = let
          pkgAttrs = {
            ps2pkgs = self'.packages;
          };

          callPkg = pkgs.callPackage;
        in {
          dvp-binutils = callPkg ./pkgs/dvp-binutils pkgAttrs; 
          iop-binutils = callPkg ./pkgs/iop-binutils pkgAttrs;

          ee-binutils = callPkg ./pkgs/ee-binutils pkgAttrs;
          ee-stage1-gcc = callPkg ./pkgs/ee-stage1-gcc pkgAttrs;
          ee-newlib = callPkg ./pkgs/ee-newlib pkgAttrs;
          ee-newlib-nano = callPkg ./pkgs/ee-newlib-nano pkgAttrs;
          ee-pthread-embedded = callPkg ./pkgs/ee-pthread-embedded pkgAttrs;
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
