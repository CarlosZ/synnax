{ lib, isDev, ... }:
{
  vim = {
    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        indent.enabled = true;
        input.enabled = true;
        notifier.enabled = true;
        picker.enabled = true;
        quickfile.enabled = true;
        scope.enabled = true;
        scroll.enabled = true;
        statuscolumn.enabled = true;
        toggle.enabled = true;
        words.enabled = true;
      };
    };
    maps = {
      normal = {
        "<leader><leader>" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.smart()
            end
          '';
          desc = "Smart find";
        };
        "<leader>bb" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.buffers()
            end
          '';
          desc = "Buffers";
        };
        "<leader>fR" = {
          action = ''
            function()
              require("snacks").picker.recent()
            end
          '';
          lua = true;
          desc = "Recent files";
        };
        "<leader>sg" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.grep()
            end
          '';
          desc = "Live grep";
        };
      }
      // lib.optionalAttrs isDev {
        "<leader>gl" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.git_log()
            end
          '';
          desc = "Git log";
        };
      };
    };
  };
}
