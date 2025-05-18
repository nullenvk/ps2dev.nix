{pkgs, ps2pkgs, ...}:
let 
    ps2Target = "mips64r5900el-ps2-elf";
in
pkgs.stdenv.mkDerivation rec {
    pname = "ee-pthread-embedded";
    version = "20240403";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "pthread-embedded";
        rev = "4f43d30a23e8ac6d0334aef64272b4052b5bb7c2"; # platform-agnostic 
        hash = "sha256-k6fR1RxblNehIdQn22E9vbL4hsRZFphKIsbZAxsD/QE="; 
    };

    buildInputs = [
        ps2pkgs.ee-binutils
        ps2pkgs.ee-stage1-gcc
        ps2pkgs.ee-newlib
        pkgs.texinfo
        pkgs.gnumake
        pkgs.flex
        pkgs.bison
    ];

    sourceRoot = "${src.name}/platform/ps2";

    preBuild = ''
        makeFlagsArray+=(GLOBAL_CFLAGS="-I. -I../.. -I../helper -I${ps2pkgs.ee-newlib}/${ps2Target}/include")
        makeFlagsArray+=(DESTDIR="$out/${ps2Target}")
    '';

    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
