{ lib, config, ... }:
{
  vim = {
    autocomplete.blink-cmp = {
      enable = true;
      setupOpts = {
        keymap = {
          preset = "enter";
          "<C-y>" = [ "select_and_accept" ];
        };
        cmdline = {
          enabled = true;
          keymap = {
            preset = "cmdline";
            "<Down>" = [
              "select_next"
              "fallback"
            ];
            "<Up>" = [
              "select_prev"
              "fallback"
            ];
          };
          completion.menu.auto_show = true;
        };
      };
      mappings = lib.mapAttrs (_: _: null) config.vim.autocomplete.blink-cmp.mappings;
    };
    maps.command = {
      "<Esc>" = {
        action = "<C-c>";
      };
    };
  };
}
