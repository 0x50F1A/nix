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
      graphics = {
        enable = true;
        extraPackages = builtins.attrValues { inherit (pkgs) nvidia-vaapi-driver vaapiVdpau; };
        extraPackages32 = builtins.attrValues {
          inherit (pkgs.pkgsi686Linux) nvidia-vaapi-driver vaapiVdpau;
        };
      };
      nvidia = {
        modesetting.enable = true;
        forceFullCompositionPipeline = false;
        nvidiaSettings = true;
        open = true;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
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

    hardware.nvidia-container-toolkit.enable = lib.mkIf config.virtualisation.docker.enable true;
  };
}
