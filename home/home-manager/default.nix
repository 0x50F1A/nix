_: {
  home = {
    enableDebugInfo = true;
    enableNixpkgsReleaseCheck = true;
    stateVersion = "24.05";
  };
  manual = {
    manpages.enable = true;
    html.enable = true; # did not build as of 2024-03-28
    json.enable = true;
  };
  programs.home-manager.enable = true;
}
