{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;
  options.sof.nvidia = {
    enable = lib.mkEnableOption "Soaffine Nvidia Configuration" // {
      default = true;
    };
  };
  config = lib.mkIf config.sof.nvidia.enable {
    environment.systemPackages = builtins.attrValues {
      inherit (pkgs) ddcutil;
      # inherit (pkgs.cudaPackages) cudatoolkit cudnn; # cutensor; # tensorrt;
      # inherit (pkgs.nvtopPackages) full;
    };

    hardware = {
      opengl = {
        enable = true;
        extraPackages = builtins.attrValues { inherit (pkgs) nvidia-vaapi-driver vaapiVdpau; };
        extraPackages32 = builtins.attrValues {
          inherit (pkgs.pkgsi686Linux) nvidia-vaapi-driver vaapiVdpau;
        };
        driSupport = true;
        driSupport32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
        forceFullCompositionPipeline = false;
        nvidiaSettings = true;
        open = true;
        # package = config.boot.kernelPackages.nvidiaPackages.beta;
        package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "555.42.02";
          sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
          sha256_aarch64 = "sha256-ekx0s0LRxxTBoqOzpcBhEKIj/JnuRCSSHjtwng9qAc0=";
          openSha256 = "sha256-3/eI1VsBzuZ3Y6RZmt3Q5HrzI2saPTqUNs6zPh5zy6w=";
          settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
          persistencedSha256 = "sha256-3ae31/egyMKpqtGEqgtikWcwMwfcqMv2K4MVFa70Bqs=";
        };
        powerManagement = {
          enable = true;
          finegrained = false;
        };
      };
    };

    programs.atop = {
      atopgpu.enable = true;
    };

    services = {
      xserver = {
        enable = true;
        videoDrivers = [ "nvidia" ];
      };
    };

    virtualisation.docker.enableNvidia = lib.mkIf config.virtualisation.docker.enable true;
  };
}
