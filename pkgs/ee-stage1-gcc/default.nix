{stdenv, pkgs}:
stdenv.mkDerivation {
    pname = "iop-stage1-gcc";
    version = "2.44.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "gcc";
        rev = "6247ca1b3695a76aae19fb7f88acc72e05850771"; # iop-v2.44.0 branch
        hash = "sha256-3oY8/oYna+sZ1+qy1MXAJKAQDiSFzTdbooaKxxAxYTE=";
    };

    buildInputs = [
        pkgs.gcc
        pkgs.gmp
        pkgs.libmpc
        pkgs.mpfr
        pkgs.texinfo
        pkgs.gnumake
        pkgs.flex
        pkgs.bison
    ];

    configureFlags = [
        "--target=mips64r5900el-ps2-elf"
        "--program-prefix=iop-stage1-"
        "--enable-languages=c"
        "--with-float=hard"
        "--without-headers"
        "--without-newlib"
        "--disable-libgcc"
        "--disable-shared"
        "--disable-threads"
        "--disable-multilib"
        "--disable-libatomic"
        "--disable-nls"
        "--disable-tls"
        "--disable-libssp"
        "--disable-libgomp"
        "--disable-libmudflap"
        "--disable-libquadmath"
    ];

    dontUpdateAutotoolsGnuConfigScripts = true;
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
