{ config, lib, ... }:
{
  _file = ./default.nix;

  options.sof.librewolf = {
    enable = lib.mkEnableOption "Soaffine Librewolf Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.librewolf.enable {
    programs = {
      librewolf = {
        enable = true;
        # settings = {
        #   browser.sessionstore.resume_from_crash = "false";
        #   media.autoplay.block_policy = 2;
        #   privacy.resistFingeprinting.letterboxing = "true";
        # };
      };
    };
  };
}
