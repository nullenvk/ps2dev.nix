{pkgs, ps2pkgs, ...}:
pkgs.stdenv.mkDerivation {
    pname = "ee-newlib";
    version = "4.5.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "newlib";
        rev = "e05bdf9996a85e47c8166353328396c11490d40f"; # ee-v4.5.0
        hash = "sha256-y5xcHefvStoK8BN5F/ZTfZgZk0fiFfA7df6GFJZ8/hM="; 
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
    ];

    dontUpdateAutotoolsGnuConfigScripts = true;
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
