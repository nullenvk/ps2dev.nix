{stdenv, pkgs, ...}:
stdenv.mkDerivation {
    pname = "dvp-binutils";
    version = "2.44.0";

    src = pkgs.fetchFromGitHub {
        owner = "ps2dev";
        repo = "binutils-gdb";
        rev = "0aef5ed1686ba47069392798a5d4fd03d183bf8a"; # dvp-v2.44.0 branch
        hash = "sha256-gKldknLyP22v+b5nynrJwY0THj84dQD39/b4THhoayI=";
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

    patches = [
        ./deterministic.patch
    ];

    configureFlags = [
        "--target=dvp"
        "--disable-nls"
        "--disable-build-warnings"
    ];

    dontUpdateAutotoolsGnuConfigScripts = true;
    dontStrip = true; # is it necessary?
    dontDisableStatic = true;
    hardeningDisable = ["all"];
}
