{ lib, ... }:
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
  networking.hostName = "desktop";
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
      ];
      kernelModules = [ ];
    };
    extraModulePackages = [ ];
    kernelModules = [ "kvm-intel" ];
    supportedFilesystems = [ "ntfs" ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/67bbf1e9-760c-4ea8-b456-49cc0493d560";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/64F0-2246";
      fsType = "vfat";
    };

    "/mnt/windows" = {
      device = "/dev/disk/by-uuid/162C0C4E2C0C2AF7";
      fsType = "ntfs-3g";
      options = ntfs_options;
    };

    "/mnt/windows-games" = {
      device = "/dev/disk/by-uuid/8A18BD4E18BD3A51";
      fsType = "ntfs-3g";
      options = ntfs_options;
    };

    "/mnt/windows-storage" = {
      device = "/dev/disk/by-uuid/8C1EE8AB1EE8900E";
      fsType = "ntfs-3g";
      options = ntfs_options;
    };
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
}
