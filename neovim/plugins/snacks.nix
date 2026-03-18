{
  vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        indent.enabled = true;
        input.enabled = true;
        keymap.enabled = true;
        notifier.enabled = true;
        picker = {
          enabled = true;
          sources.notifications.win.preview.wo.wrap = true;
        };
        quickfile.enabled = true;
        rename.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;
        toggle.enabled = true;
        words.enabled = true;
        styles.notification.wo.wrap = true;
      };
    };
  };
}
