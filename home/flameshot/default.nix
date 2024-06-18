{ flake, ... }:
{
  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          savePath = "/home/${flake.config.affineUser.name}/Pictures";
          saveAsFileExtension = ".png";
          uiColor = "#2d0096";
          checkForUpdates = false;
        };
      };
    };
  };
}
