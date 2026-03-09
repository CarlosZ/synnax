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
        "<leader>sb" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.lines()
            end
          '';
          desc = "Buffer lines";
        };
        "<leader>s\"" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.registers()
            end
          '';
          desc = "Registers";
        };
        "<leader>sn" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.notifications()
            end
          '';
          desc = "Notification History";
        };
        "<leader>sm" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.marks()
            end
          '';
          desc = "Marks";
        };
        "<leader>su" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.undo()
            end
          '';
          desc = "Undo History";
        };
        "<leader>uu" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.undo()
            end
          '';
          desc = "Undo History";
        };
      }
      // lib.optionalAttrs isDev {
        "<leader>gl" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.git_log({
                confirm = function(picker, item)
                  picker:close()
                  if item and item.commit then
                    vim.cmd("DiffviewOpen " .. item.commit);
                  end
                end,
              })
            end
          '';
          desc = "Git log";
        };
        "<leader>gs" = {
          lua = true;
          action = ''
            function()
              require("snacks").picker.git_status()
            end
          '';
          desc = "Modified files";
        };
      };
    };
  };
}
