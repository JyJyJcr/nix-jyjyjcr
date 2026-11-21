{
  stdenvNoCC,
  lib, # fetchurl,
}:

stdenvNoCC.mkDerivation {
  pname = "agent-skill-set";
  version = "1.0.0";

  outputs = [
    "out"
  ];

  src = ./.;

  #dontUnpack = true;

  nativeBuildInputs = [ ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/agent-skill-set"
    cp -r simulation-software-engineering "$out/share/agent-skill-set/"

    runHook postInstall
  '';

  meta = {
    description = "Agent skill set for various tasks";
    license = lib.licenses.wtfpl;
    platforms = lib.platforms.all;
  };
}
