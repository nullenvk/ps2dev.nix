{pkgs, ps2pkgs, ...}:
let
    ps2Target = "mips64r5900el-ps2-elf";
in
pkgs.stdenv.mkDerivation {
    pname = "ee-newlib-nano";
    version = "4.5.0";

    NIX_CFLAGS_COMPILE = "-DPREFER_SIZE_OVER_SPEED=1 -Os -gdwarf-2 -gz";

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
        "--disable-newlib-supplied-syscalls"
        "--enable-newlib-reent-small"
        "--disable-newlib-fvwrite-in-streamio"
        "--disable-newlib-fseek-optimization"
        "--disable-newlib-wide-orient"
        "--enable-newlib-nano-malloc"
        "--disable-newlib-unbuf-stream-opt"
        "--enable-lite-exit"
        "--enable-newlib-global-atexit"
        "--enable-newlib-nano-formatted-io"
        "--enable-newlib-retargetable-locking"
        "--enable-newlib-multithread"
        "--disable-nls"
    ];

    postInstall = ''
        mv $out/${ps2Target}/lib/libc.a $out/${ps2Target}/lib/libc_nano.a
        mv $out/${ps2Target}/lib/libm.a $out/${ps2Target}/lib/libm_nano.a
        mv $out/${ps2Target}/lib/libg.a $out/${ps2Target}/lib/libg_nano.a
    '';

    dontUpdateAutotoolsGnuConfigScripts = true;
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
