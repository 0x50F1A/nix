{ lib, pkgs, ... }:
{
  home.packages = builtins.attrValues { inherit (pkgs) jc; };
  programs = {
    nushell = {
      enable = true;
      # https://github.com/n3oney/nixus/blob/eef49b9e5e5c76e0b808f4c4334ce169e1c053de/modules/programs/nushell.nix#L118
      configFile.text =
        let
          opaquewrap =
            binary:
            with builtins;
            with lib;
            ''
              printf "\\033]11;rgba:${concatStringsSep "/" (match "([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})" "191724")}/ff\\007"

              ^${binary} ...$args

              printf "\\033]11;rgba:${concatStringsSep "/" (match "([0-9a-fA-F]{2})([0-9a-fA-F]{2})([0-9a-fA-F]{2})" "191724")}/${
                toHexString (floor (0.7 * 255))
              }\\007"
            '';
        in
        ''
          $env.TRANSIENT_PROMPT_COMMAND = "\u{f17b5} "

          def --wrapped hx [...args] {
            ${opaquewrap "hx"}
          }

          def --wrapped btop [...args] {
            ${opaquewrap "btop"}
          }

          let carapace_completer = {|spans|
            ${lib.getExe pkgs.carapace} $spans.0 nushell ...$spans | from json
          }

          let fish_completer = {|spans|
            ${lib.getExe pkgs.fish} --command $'complete "--do-complete=($spans | str join " ")"'
            | $"value(char tab)description(char newline)" + $in
            | from tsv --flexible --no-infer
          }

          let zoxide_completer = {|spans|
              $spans | skip 1 | ${lib.getExe pkgs.zoxide} query -l ...$in | lines | where {|x| $x != $env.PWD}
          }

          let completer_composition = {|spans|
            let expanded_alias = scope aliases | where name == $spans.0 | get -i 0.expansions

            let spans = if $expanded_alias != null {
              $spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }

            match $spans.0 {
              nu => $fish_completer,${
                # carapace incorrectly completes nu
                ""
              }
              git => $fish_completer,${
                # fish completes commits and branch names nicely
                ""
              }
              ssh => $fish_completer,${
                # fish completes hosts from ssh config
                ""
              }

              z => $zoxide_completer,

              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
            show_banner: false
            completions: {
              external: {
                enable: true
                completer: $completer_composition
              }
            }
          }
        '';
      shellAliases = {
        cat = "${lib.getExe pkgs.bat}";
        # cd = "${lib.getExe pkgs.zoxide}"; 
        # Eza predefines these...
        # la = "ls -la";
        # ll = "ls -l";
      };
    };
  };
}
