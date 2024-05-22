{flake, ...}: let
  username = flake.config.people.myself;
in {
  home = {
    stateVersion = "24.05";
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
    };
  };
}
