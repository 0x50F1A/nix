{ lib, pkgs, ... }:
let
  ntfs_options = [
    "rw"
    "allow_other"
    "uid=1000"
    "gid=1000"
    "big_writes"
  ];
in
{
  imports = [ ];
  system.stateVersion = "24.05";
  networking.hostName = "laptop";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "usb_storage"
        "nvme"
        "usbhid"
        "sd_mod"
        "sdhci_pci"
      ];
      kernelModules = [ ];
      secrets = {
        "/crypto_keyfile.bin" = null;
      };
    };
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "mem_sleep_default=deep" ];
    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/929eaab6-05fc-4a53-9665-3b4c10237ca9";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-92c869f2-0ee8-4a23-809f-8e5c6da01e6f".device = "/dev/disk/by-uuid/92c869f2-0ee8-4a23-809f-8e5c6da01e6f";

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/36A1-02FE";
    fsType = "vfat";
  };

  swapDevices = [ ];

  hardware = {
    cpu = {
      intel = {
        updateMicrocode = true;
      };
    };
    enableAllFirmware = true;
  };
  networking.useDHCP = lib.mkDefault true;
  programs.dconf.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  # HiDPI Options
  # hardware.video.hidpi.enable = true;
  # fonts.optimizeForVeryHighDPI = true;
  services.xserver = {
    dpi = 153;
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
        Xft.dpi: 153
        Xcursor.size: 32
      EOF
    '';
  };
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };
}
