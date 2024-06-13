{
  lib,
  fetchurl,
  appimageTools,
}: let
  pname = "cursor";
  version = "0.33";
  src = fetchurl {
    url = "https://downloader.cursor.sh/linux/appImage/x64";
    name = "${pname}-${version}.4x86_64.AppImage";
    sha256 = "sha256:0z7zkdfmzswciifyj2mqn3ksa091sx4a6jrqh62ygkqprxigkb1xsha256:0z7zkdfmzswciifyj2mqn3ksa091sx4a6jrqh62ygkqprxigkb1x";
  };
in
  appimageTools.wrapType2 {
    name = pname;

    extraInstallCommands = let
      contents = appimageTools.extractType2 {inherit pname version src;};
    in ''
      mkdir -p "$out/share/applications"
      mkdir -p "$out/share/lib/${pname}"
      cp -r ${contents}/{locales,resources} "$out/share/lib/${pname}"
      cp -r ${contents}/usr/* "$out"
      cp "${contents}/${pname}.desktop" "$out/share/applications/"
      substituteInPlace $out/share/applications/${pname}.desktop --replace 'Exec=AppRun' 'Exec=${pname}'
    '';

    meta = with lib; {
      description = "An editor made for pair-programming with AI.";
      homepage = "https://cursor.sh";
      license = {
        fullname = "Cursor End User License Agreement";
        url = "https://cursor.sh/license.txt";
        free = false;
        redistributable = false;
      };
      maintainers = [soaffine];
      mainProgram = "cursor";

      platforms = ["x86_64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];

      longDescription = ''
        A fork of Visual Studio Code for pair programming with OpenAI and custom products.
      '';
    };
  }
