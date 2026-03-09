{
  lib,
  config,
  isDev,
  ...
}:
{
  vim = {
    clipboard = {
      providers = {
        xclip.enable = true;
      };
      registers = "unnamedplus";
    };

    session.nvim-session-manager = lib.mkIf isDev {
      enable = true;
      setupOpts = {
        autoload_mode = "CurrentDir";
        autosave_ignore_dirs = [ "/tmp" ];
      };
      mappings = lib.mapAttrs (_: _: null) config.vim.session.nvim-session-manager.mappings;
    };
  };
}
