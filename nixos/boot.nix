{pkgs, ...}: {
  boot = {
    # binfmt.registrations.appimage = {
    #   wrapInterpreterInShell = false;
    #   interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    #   recognitionType = "magic";
    #   offset = 0;
    #   mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    #   magicOrExtension = ''\x7fELF....AI\x02'';
    # };
    loader = {
      systemd-boot = {
        enable = true;
        editor = true;
        configurationLimit = 4;
        consoleMode = "auto";
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 10;
    };
    kernelPackages = pkgs.linuxPackages_zen;

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = "524288";
    };
  };

  # Speed up boot
  # https://discourse.nixos.org/t/boot-faster-by-disabling-udev-settle-and-nm-wait-online/6339
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
}
