{ flake, pkgs, ... }:
{
  programs = {
    git = {
      enable = true;
      delta = {
        enable = true;
      };
      # TODO: Compare delta to these
      # difftastic = {
      #   enable = true;
      # };
      # riff = {
      #   enable = true;
      # };
      userName = flake.config.affineUser.name;
      userEmail = flake.config.affineUser.email;
    };
  };
  home.packages = [ pkgs.git-absorb ];
}
