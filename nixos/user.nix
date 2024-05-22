{
  pkgs,
  flake,
  ...
}: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.nushell;
    users.${flake.config.people.myself} = {
      isNormalUser = true;
      description = "Main administration account for myself";
      extraGroups = ["networkmanager" "wheel" "video" "audio"];
      hashedPassword = "$y$j9T$Xrr9lauxcb9nD0P9h94qK/$NIjdpHuxCbrOOtp5Oo5g1zEBRaEskialcka5qm3VX29";
      openssh.authorizedKeys.keys = flake.config.people.myself.sshKeys;
    };
  };

  programs.zsh.enable = true;
}
