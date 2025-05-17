{stdenv, pkgs, ...}:
stdenv.mkDerivation {
    pname = "ee-binutils";
    version = "2.44.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "binutils-gdb";
        rev = "94bfc7644361b2d610a60203372c7bd676b38606"; # ee-v2.44.0 branch
        hash = "sha256-g0YihbgEW1SsGbgi8r1iKqUj8sJmJE2Y3gVvm+98bAc=";
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
        pkgs.perl
    ];

    patches = [
        ./deterministic.patch
    ];

    configureFlags = [
        "--target=mips64r5900el-ps2-elf"
        "--program-prefix=ee-"
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
