{pkgs, ps2pkgs, ...}:
let
    ps2Target = "mips64r5900el-ps2-elf";
    ps2BuildEnv = pkgs.buildEnv {
        name = "ps2BuildEnv";
        paths = [ ps2pkgs.ee-binutils ps2pkgs.ee-stage1-gcc ];
        pathsToLink = [("/" + ps2Target)];
    };
in
pkgs.stdenv.mkDerivation {
    pname = "ee-newlib";
    version = "4.5.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "newlib";
        rev = "efcc3af0f9a8ae6ceaee4a3532f1db948edcc067"; # ee-v4.5.0
        hash = "sha256-GHCevJtKJCERs2atAjJwy7rIeajRipfiT3nk+7r5btM="; 
    };

    buildInputs = [
        ps2pkgs.ee-binutils
        ps2pkgs.ee-stage1-gcc
        pkgs.texinfo
        pkgs.gnumake
        pkgs.flex
        pkgs.bison
    ];

    configureFlags = [
        "--target=mips64r5900el-ps2-elf"
        "--enable-newlib-retargetable-locking"
        "--enable-newlib-multithread"
        "--enable-newlib-io-c99-formats"
        "--with-sysroot=${ps2BuildEnv}/mips64r5900el-ps2-elf"
    ];

    #dontUpdateAutotoolsGnuConfigScripts = true;
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
