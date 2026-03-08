{
  vim = {
    autocomplete.blink-cmp = {
      enable = true;
      setupOpts = {
        keymap = {
          preset = "default";
        };
        cmdline.keymap = {
          preset = "inherit";
        };
      };
    };
    clipboard = {
      providers = {
        xclip.enable = true;
      };
      registers = "unnamedplus";
    };
  };
}
