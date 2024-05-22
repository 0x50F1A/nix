{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      extest = {
        enable = true;
      };
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
      gamescopeSession = {
        enable = true;
        args = ["--expose-wayland -e"];
      };
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
    };
  };

  environment.systemPackages = [
    pkgs.protonup-qt
    pkgs.lutris
  ];
}
