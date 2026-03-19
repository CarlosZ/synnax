{ lib, isDev, ... }:
{
  vim = {
    languages = {
      enableTreesitter = true;
      enableFormat = true;
      enableExtraDiagnostics = true;

      json.enable = true;
      markdown.enable = true;
      toml = {
        enable = true;
        extraDiagnostics.enable = false;
      };
      yaml.enable = true;
    }
    // lib.optionalAttrs isDev {
      bash.enable = true;
      lua.enable = true;
      nix = {
        enable = true;
        format.type = [ "nixfmt" ];
      };
    };
  };
}
