{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.ocaml = {
    enable = lib.mkEnableOption "Soaffine OCaml Home Configuration" // {
      default = false;
    };
  };

  config = lib.mkIf config.sof.ocaml.enable {
    warnings = lib.optional (config.sof.ocaml.enable) ''
      OCaml is enabled system-wide. While this is okay, a better strategy is to leverage devShells per-project.
    '';
    programs = {
      opam = {
        enable = true;
      };
    };
  };
}
