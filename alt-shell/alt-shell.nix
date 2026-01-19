{ buildEnv, mkShell }: rec {
  # alter shell by applying a list of functions ()
  alterShell = shell: funcList:
    builtins.foldl' (accShell: func: func accShell) shell funcList;
  # add escaped fpath of zsh completion files to shell environment (buildEnv)
  conveyZshCompletion = { varName ? "ALTSHELL_ZSH_COMPLETION_FPATH_ESCAPED"
    , takeBuildInputs ? false, takeNativeBuildInputs ? true
    , takePropagatedBuildInputs ? false, takePropagatedNativeBuildInputs ? false
    , }:
    shell:
    shell.overrideAttrs (oldAttrs:
      let
        zshCompEnv = buildEnv {
          name = "zsh-comp";
          paths = [ ] ++ (if takeBuildInputs then oldAttrs.buildInputs else [ ])
            ++ (if takeNativeBuildInputs then
              oldAttrs.nativeBuildInputs
            else
              [ ]) ++ (if takePropagatedBuildInputs then
                oldAttrs.propagatedBuildInputs
              else
                [ ]) ++ (if takePropagatedNativeBuildInputs then
                  oldAttrs.propagatedNativeBuildInputs
                else
                  [ ]);
          pathsToLink = [ "/share/zsh" ];
        };
      in { "${varName}" = "${zshCompEnv}/share/zsh/site-functions"; });
  # make bash-ized shell (mkShell, alterShell)
  mkBashShell = { }: attrs: alterShell (mkShell attrs) [ ];
  # make zsh-ized shell (mkShell, alterShell, conveyZshCompletion)
  mkZshShell = { completionArgs ? { } }:
    attrs:
    alterShell (mkShell attrs) [ (conveyZshCompletion completionArgs) ];
  # make common shells (mkShell, mkBashShell, mkZshShell)
  mkCommonShells =
    { enableBash ? true, bashArgs ? { }, enableZsh ? true, zshArgs ? { }, }:
    attrs: {
      default = mkShell attrs;
      bash = if enableBash then (mkBashShell bashArgs attrs) else null;
      zsh = if enableZsh then (mkZshShell zshArgs attrs) else null;
    };
}
