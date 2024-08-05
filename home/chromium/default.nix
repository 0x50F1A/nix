{
  config,
  lib,
  pkgs,
  ...
}:
{
  _file = ./default.nix;

  options.sof.edge = {
    enable = lib.mkEnableOption "Soaffine Edge Home Configuration" // {
      default = true;
    };
  };

  config = lib.mkIf config.sof.edge.enable {
    programs = {
      chromium = {
        enable = false;
        package = pkgs.microsoft-edge;
        commandLineArgs = [
          "--enable-features=UseOzonePlatform"
          "--ozone-platform=wayland"
        ];
        extensions = [
          { id = "ammjkodgmmoknidbanneddgankgfejfh"; } # 7TV
          { id = "ajopnjidmegmdimjlfnijceegpefgped"; } # BetterTTV
          { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
          { id = "mpbjkejclgfgadiemmefgebjfooflfhl"; } # Buster
          {
            id = "dcpihecpambacapedldabdbpakmachpb";
            updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/src/updates/updates.xml";
          } # Bypass Paywalls
          { id = "cofdbpoegempjloogbagkncekinflcnj"; } # DeepL
          { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
          { id = "kbfnbcaeplbcioakkpcpgfkobkghlhen"; } # Grammarly
          { id = "ndjpnladcallmjemlbaebfadecfhkepb"; } # Microsoft 365
          { id = "fbgcedjacmlbgleddnoacbnijgmiolem"; } # Microsoft Bing Rewards
          { id = "gpaiobkfhnonedkhhfjpmhdalgeoebfa"; } # Microsoft Editor
          { id = "nkhogfcnhgccnigkfnkmdpmcoehofabn"; } # PiP Everywhere
          { id = "dgjhfomjieaadpoljlnidmbgkdffpack"; } # Sourcegraph
          { id = "jghecgabfgfdldnmbfkhmffcabddioke"; } # Volume Master
          { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
        ];
      };
    };
  };
}
