_: {
  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["bryn"];
          keepEnv = true;
          noPass = true;
        }
      ];
      wheelNeedsPassword = false;
    };
    sudo = {
      enable = false;
      wheelNeedsPassword = false;
    };
    sudo-rs = {
      enable = true;
      wheelNeedsPassword = false;
      execWheelOnly = true;
    };
    polkit = {
      enable = true;
    };
  };
}
