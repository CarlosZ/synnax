{ lib, isDev, ... }:
{
  vim = {
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    binds.whichKey = {
      enable = true;
      setupOpts = {
        preset = "helix";
      };
      register = {
        "<leader>b" = "+Buffers";
        "<leader>c" = "+Code";
        "<leader>f" = "+File";
        "<leader>s" = "+Search";
        "<leader>w" = "+Window";
      }
      // lib.optionalAttrs isDev {
        "<leader>g" = "+Git";
      };
    };

    maps = {
      normal = {
        # Buffer management
        "<leader>bd" = {
          action = ":bdelete<CR>";
          desc = "Delete buffer";
        };
        "<leader>bD" = {
          action = "<cmd>bd<CR><cmd>close<CR>";
          desc = "Delete buffer and window";
        };
        "<leader>bo" = {
          action = "<cmd>%bd|e#|bd#<CR>";
          desc = "Delete other buffers";
        };

        # Window management
        "<leader>wd" = {
          action = "<C-w>c";
          desc = "Delete/close window";
        };
        "<leader>-" = {
          action = "<C-w>s";
          desc = "Split window horizontally";
        };
        "<leader>|" = {
          action = "<C-w>v";
          desc = "Split window vertically";
        };
      };
      visual = {
        # Keep selection after indent
        "<" = {
          action = "<gv";
          desc = "Indent left";
        };
        ">" = {
          action = ">gv";
          desc = "Indent right";
        };
        "p" = {
          action = ''
            function()
              return 'pgv"' .. vim.v.register .. "y"
            end
          '';
          lua = true;
          noremap = true;
          expr = true;
        };
      };
    };
  };
}
