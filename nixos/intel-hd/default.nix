{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.intel-hd = {
    enable = lib.mkEnableOption "Soaffine Intel-HD GPU Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.intel-hd.enable {
    environment = {
      systemPackages = [
        pkgs.libva-utils
        pkgs.vdpauinfo
      ];
      variables = {
        VDPAU_DRIVER = "va_gl";
        LIBVA_DRIVER_NAME = "iHD";
      };
    };

    hardware = {
      graphics = {
        enable = true;
        extraPackages = builtins.attrValues {
          inherit (pkgs)
            intel-media-driver
            libva
            libvdpau-va-gl
            vaapiIntel
            vaapiVdpau
            vulkan-loader
            vulkan-validation-layers
            vulkan-tools
            ;
        };
        extraPackages32 = builtins.attrValues {
          inherit (pkgs.pkgsi686Linux)
            intel-media-driver
            libva
            libvdpau-va-gl
            vaapiIntel
            vaapiVdpau
            ;
        };
      };
    };

    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "intel" ];
      };
    };
  };
}
