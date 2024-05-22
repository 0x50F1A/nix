{pkgs, ...}: {
  home.packages = builtins.attrValues {inherit (pkgs) jc;};
  programs = {
    nushell = {
      enable = true;
      configFile.text = ''
        $env.config = {
          show_banner: false
        }
        $env.TRANSIENT_PROMPT_COMMAND = "\u{f17b5} "
      '';
      shellAliases = {
        cat = "bat";
        # Eza predefines these...
        # la = "ls-la";
        # ll = "ls -l";
      };
    };
  };
}
