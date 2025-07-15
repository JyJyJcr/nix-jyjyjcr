{ stdenvNoCC, lib, fetchurl, texlive, gnuplotWithLua }:

stdenvNoCC.mkDerivation {
  pname = "gnuplot-lua-tikz";
  version = "1.0.0";

  outputs = [
    "out" # we don't add anything, but buildEnv requires this to avoid errors
    "tex"
  ];
  passthru.tlDeps = with texlive; [ latex ];

  # srcs = [
  #   (fetchurl {
  #     url = "http://mirrors.ctan.org/macros/latex/contrib/foiltex/foiltex.dtx";
  #     hash = "sha256-/2I2xHXpZi0S988uFsGuPV6hhMw8e0U5m/P8myf42R0=";
  #   })
  #   (fetchurl {
  #     url = "http://mirrors.ctan.org/macros/latex/contrib/foiltex/foiltex.ins";
  #     hash = "sha256-KTm3pkd+Cpu0nSE2WfsNEa56PeXBaNfx/sOO2Vv0kyc=";
  #   })
  # ];
  src = ./.;

  nativeBuildInputs = [
    #(texliveSmall.withPackages (ps: with ps; [ cm-super hypdoc latexmk ]))
    # multiple-outputs.sh fails if $out is not defined
    # (writeShellScript "force-tex-output.sh" ''
    #   out="''${tex-}"
    # '')
    gnuplotWithLua
    #writableTmpDirAsHomeHook # Need a writable $HOME for latexmk
  ];

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
    #maintainers = with lib.maintainers; [ veprbl ];
    platforms = lib.platforms.all;
  };
}
