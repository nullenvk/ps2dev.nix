{stdenv, pkgs, ...}:
stdenv.mkDerivation {
    pname = "iop-binutils";
    version = "2.44.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "binutils-gdb";
        rev = "8eb2cecff5a113ae3931732897d26659d9434006"; # iop-v2.44.0 branch
        hash = "sha256-BMUnRzm231ipMvbWzewtmyVZ6z5rWmpEK4UCaiai55M=";
    };

    nativeBuildInputs = [
        pkgs.gcc
        pkgs.gmp
        pkgs.libmpc
        pkgs.mpfr
        pkgs.texinfo
        pkgs.gnumake
        pkgs.flex
        pkgs.bison
        pkgs.perl
        pkgs.m4
    ];

    patches = [
        ./deterministic.patch
    ];

    configureFlags = [
        "--target=mipsel-none-elf"
        "--program-prefix=iop-"
        "--disable-separate-code"
        "--disable-sim"
        "--disable-nls"
        "--with-python=no"
        "--disable-build-warnings"
    ];

    dontUpdateAutotoolsGnuConfigScripts = true;
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
