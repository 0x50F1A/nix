{ flake, ... }:
let
  username = flake.config.affineUser.name;
in
{
  home = {
    stateVersion = "24.05";
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = { };
  };
}
