{
  config,
  lib,
  ...
}: {
  _file = ./default.nix;

  options.sof.aria2 = {
    enable =
      lib.mkEnableOption "Soaffine Aria2 Home Configuration"
      // {
        default = true;
      };
  };

  config = lib.mkIf config.sof.aria2.enable {
    programs = {
      aria2 = {
        enable = true;
        settings = {
          allow-overwrite = true;
          continue = true;
          disk-cache = "128M";
          enable-http-pipelining = true;
          file-allocation = "none";
          max-connection-per-server = 16;
          min-split-size = "1M";
          split = 32;
          summary-interval = 30;
        };
      };
    };
  };
}
