{pkgs, ...}: {
  environment = {
    enableAllTerminfo = true;
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      NIZOS_OZONE_WL = "1";
    };
    systemPackages = builtins.attrValues {
      inherit
        (pkgs)
        appimage-run
        curl
        dnsutils
        dosfstools
        efibootmgr
        gptfdisk
        git
        inetutils
        iputils
        killall
        nethogs
        nil
        pciutils
        sshfs
        smem
        sysstat
        usbutils
        util-linux
        wget
        ;
    };
  };
}
