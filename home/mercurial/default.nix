{ flake, ... }:
{
  programs = {
    mercurial = {
      enable = true;
      userName = flake.config.affineUser.name;
      userEmail = flake.config.affineUser.email;
    };
  };
}
