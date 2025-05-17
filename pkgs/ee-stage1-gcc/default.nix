{stdenv, pkgs, ps2pkgs}:
let
    binutils = ps2pkgs.ee-binutils;
in
stdenv.mkDerivation {
    pname = "ee-stage1-gcc";
    version = "2.44.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "gcc";
        rev = "5c68fdf5209b133fb878dee62035eb8ff3ae4024"; # ee-v14.2.0
        hash = "sha256-SsFk3Nlg6AR+wV/VHKdvDNBkbFw9yK029JUNxdYxEds="; 
    };

    patches = [
        # TODO: Port source date epoch patches
        #./use-source-date-epoch.patch
    ];

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
    
    nativeInputs = [
        binutils
    ];

    configureFlags = [
        "--target=mips64r5900el-ps2-elf"
        "--program-prefix=ee-stage1-"
        "--with-as=${binutils}/bin/ee-as"
        "--with-ld=${binutils}/bin/ee-ld"
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
