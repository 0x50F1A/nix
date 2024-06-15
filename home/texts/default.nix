{
  config,
  lib,
  ...
}: {
  _file = ./default.nix;

  options.sof.texts = {
    enable =
      lib.mkEnableOption "Soaffine Texts Home Configuration"
      // {
        default = false;
      };
  };

  config = lib.mkIf config.sof.texts.enable {
    warnings = lib.optional (config.sof.texts.enable) ''
      The texts module currently does not do anything. The goal should be to grab the appimage and install it.
      https://texts.com/install/linux

      As of 2024-06-13, the AppImage struggled with nvidia without nvk.
    '';
  };
}
