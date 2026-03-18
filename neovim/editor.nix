{
  lib,
  config,
  isDev,
  ...
}:
{
  vim = {
    clipboard = {
      enable = true;
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

  synnax.keys = {
    Buffers = {
      rootKey = "<leader>b";
      icon = "";
      iconColor = "cyan";
      maps = [
        {
          key = "b";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.buffers()
            end
          '';
          desc = "Buffers";
          lua = true;
        }
        {
          key = "d";
          mode = [ "n" ];
          action = "<cmd>bdelete<CR>";
          desc = "Delete buffer";
        }
        {
          key = "D";
          mode = [ "n" ];
          action = "<cmd>bd<CR><cmd>close<CR>";
          desc = "Delete buffer and window";
        }
        {
          key = "o";
          mode = [ "n" ];
          action = "<cmd>%bd|e#|bd#<CR>";
          desc = "Delete other buffers";
        }
      ];
    };

    File = {
      rootKey = "<leader>f";
      icon = "󰈔";
      iconColor = "cyan";
      maps = [
        {
          key = "R";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.recent()
            end
          '';
          desc = "Recent files";
          lua = true;
        }
      ];
    };

    Search = {
      rootKey = "<leader>s";
      icon = "";
      iconColor = "green";
      maps = [
        {
          key = "r";
          mode = [ "n" ];
          action = "<cmd>GrugFar<CR>";
          desc = "Find and replace";
        }
        {
          key = "g";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.grep()
            end
          '';
          desc = "Live grep";
          lua = true;
        }
        {
          key = "b";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.lines()
            end
          '';
          desc = "Buffer lines";
          lua = true;
        }
        {
          key = "\"";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.registers()
            end
          '';
          desc = "Registers";
          lua = true;
        }
        {
          key = "n";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.notifications({
                confirm = function(picker, item)
                  picker:close()
                  vim.fn.setreg("+", item.preview.text)
                end,
              })
            end
          '';
          desc = "Notification History";
          lua = true;
        }
        {
          key = "m";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.marks()
            end
          '';
          desc = "Marks";
          lua = true;
        }
        {
          key = "u";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.undo()
            end
          '';
          desc = "Undo History";
          lua = true;
        }
      ];
    };

    Undo = {
      rootKey = "<leader>u";
      icon = "↺";
      iconColor = "yellow";
      maps = [
        {
          key = "u";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.undo()
            end
          '';
          desc = "Undo History";
          lua = true;
        }
        {
          key = "t";
          mode = [ "n" ];
          action = "<cmd>UndotreeToggle<CR>";
          desc = "Undo tree";
        }
      ];
    };

    Window = {
      rootKey = "<leader>w";
      icon = "";
      iconColor = "blue";
      maps = [
        {
          key = "d";
          mode = [ "n" ];
          action = "<C-w>c";
          desc = "Delete/close window";
        }
      ];
    };
  }
  // lib.optionalAttrs isDev {
    Session = {
      rootKey = "<leader>e";
      icon = "󰆓";
      iconColor = "purple";
      maps = [
        {
          key = "l";
          mode = [ "n" ];
          action = "<cmd>SessionManager load_session<CR>";
          desc = "Load session";
        }
        {
          key = "a";
          mode = [ "n" ];
          action = "<cmd>SessionManager load_last_session<CR>";
          desc = "Load last session";
        }
      ];
    };
  };
}
