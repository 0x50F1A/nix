_: {
  programs.atop = {
    enable = false;
    netatop.enable = true;
    setuidWrapper.enable = true;
    atopService.enable = true;
    atopRotateTimer.enable = true;
  };
}
