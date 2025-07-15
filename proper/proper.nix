{ stdenvNoCC, lib, fetchurl, texlive, writeShellScript }:

stdenvNoCC.mkDerivation {
  pname = "proper";
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

  #dontUnpack = true;

  # unpackPhase = ''
  #   runHook preUnpack

  #   for _src in $srcs; do
  #     cp "$_src" $(stripHash "$_src")
  #   done

  #   runHook postUnpack
  # '';

  nativeBuildInputs = [
    #(texliveSmall.withPackages (ps: with ps; [ cm-super hypdoc latexmk ]))
    # multiple-outputs.sh fails if $out is not defined
    (writeShellScript "force-tex-output.sh" ''
      out="''${tex-}"
    '')
    #writableTmpDirAsHomeHook # Need a writable $HOME for latexmk
  ];

  dontConfigure = true;
  dontBuild = true;

  # buildPhase = ''
  #   runHook preBuild

  #   # Generate the style files
  #   latex foiltex.ins

  #   # Generate the documentation
  #   latexmk -pdf foiltex.dtx

  #   runHook postBuild
  # '';

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/proper"
    mkdir -p "$path"
    cp proper.sty "$path/"
    # path="$texdoc/doc/tex/latex/proper"
    # mkdir -p "$path"
    # cp *.pdf "$path/"

    runHook postInstall
  '';

  meta = {
    description = "Configured loader for frequently used packages in LaTeX";
    license = lib.licenses.wtfpl;
    #maintainers = with lib.maintainers; [ veprbl ];
    platforms = lib.platforms.all;
  };
}
