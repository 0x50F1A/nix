{ lib, pkgs, ... }: {
  programs.helix = {
    languages = {
      language = [
        {
          name = "nix";
          language-servers = [ (lib.getExe pkgs.nil) (lib.getExe pkgs.nixd) ];
          roots = [ "flake.nix" "flake.json" ];
          scope = "source.nix";
          auto-format = true;
          formatter = { command = lib.getExe pkgs.nixfmt-rfc-style; };
        }
        {
          name = "rust";
          auto-format = true;
        }
      ];
      language-server = {
        nil = {
          command = lib.getExe pkgs.nil;
          config = {
            nil.formatting.command = [ (lib.getExe pkgs.nixfmt-rfc-style) ];
          };
        };
        nixd = { command = lib.getExe pkgs.nixd; };
        rust-analyzer.config = {
          files = {
            excludeDirs = [ ".direnv" ];
            watcherExclude = [ ".direnv" ];
          };
          imports = {
            granularity.group = "module";
            prefix = "self";
          };
          cargo.buildScripts.enable = true;
          procMacro.enable = true;
          check.command = "clippy";
          lens = {
            references = true;
            methodReferences = true;
          };
          completion.autoimport.enable = true;
          experimental.procAttrMacros = true;
        };
      };
    };
  };
}
