{ stdenvNoCC, lib, texlive, gnuplotWithLua }:

stdenvNoCC.mkDerivation {
  pname = "gnuplot-lua-tikz";
  version = "1.0.0";

  outputs = [
    "out" # we don't add anything, but buildEnv requires this to avoid errors
    "tex"
  ];
  passthru.tlDeps = with texlive; [ latex ];

  src = ./.;

  nativeBuildInputs = [ gnuplotWithLua ];

  dontConfigure = true;
  buildPhase = ''
    runHook preBuild

    gnuplot -e 'set term' | cat
    gnuplot -e 'set term tikz createstyle'

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/nix-support"
    touch "$out/nix-support/proper-dummy-file"

    path="$tex/tex/latex/gnuplot-lua-tikz"
    mkdir -p "$path"
    cp "gnuplot-lua-tikz.sty" "$path/"
    cp "gnuplot-lua-tikz-common.tex" "$path/"

    runHook postInstall
  '';

  meta = {
    description = "LaTeX style files for Gnuplot tikz output";
    license = {
      # Essentially a BSD license with one modification:
      # Permission to modify the software is granted, but not the right to
      # distribute the complete modified source code.  Modifications are to
      # be distributed as patches to the released version.  Permission to
      # distribute binaries produced by compiling modified sources is granted,
      # provided you: ...

      # this is copied from nixpkgs gnuplot package
      url =
        "https://sourceforge.net/p/gnuplot/gnuplot-main/ci/master/tree/Copyright";
    };
    platforms = lib.platforms.all;
  };
}
