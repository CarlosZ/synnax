{ lib, config, ... }:
{
  config = {
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
              # This is the same as preset = 'cmdline', however
              # because Nvf doesn't allow booleans as attribute values for keymap
              # I need to recreate the entire map *without* map <Left> and <Right>
              # instead of being able to simply override their mappings to false.
              # Sighhhhh
              preset = "none";
              "<Down>" = [
                "select_next"
                "fallback"
              ];
              "<Up>" = [
                "select_prev"
                "fallback"
              ];

              "<Tab>" = [
                "show_and_insert_or_accept_single"
                "select_next"
              ];
              "<S-Tab>" = [
                "show_and_insert_or_accept_single"
                "select_prev"
              ];

              "<C-space>" = [
                "show"
                "fallback"
              ];

              "<C-n>" = [
                "select_next"
                "fallback"
              ];
              "<C-p>" = [
                "select_prev"
                "fallback"
              ];

              "<C-y>" = [
                "select_and_accept"
                "fallback"
              ];
              "<C-e>" = [
                "cancel"
                "fallback"
              ];
            };
            completion = {
              list.selection.preselect = false;
              menu.auto_show = true;
            };
          };
        };
        mappings = lib.mapAttrs (_: _: null) config.vim.autocomplete.blink-cmp.mappings;
      };
    };

    synnax.keys."_".maps = [
      {
        key = "<Esc>";
        mode = [ "c" ];
        action = "<C-c>";
      }
    ];
  };
}
