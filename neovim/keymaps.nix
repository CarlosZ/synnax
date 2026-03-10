{
  lib,
  config,
  isDev,
  ...
}:
let
  inherit (lib.nvim.lua) toLuaObject;
  inherit (lib.nvim.dag) entryAnywhere;
  cfg = config.vim.binds.whichKey;
in
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
    };

    pluginRC.whichkey = entryAnywhere ''
      local wk = require("which-key")
      wk.setup (${toLuaObject cfg.setupOpts})
      wk.add({
        { "<leader>b", desc = "+Buffers", icon = { icon = "", color = "cyan" }},
        { "<leader>f", desc = "+File", icon = { icon = "󰈔", color = "cyan" } },
        { "<leader>s", desc = "+Search", icon = { icon = "", color = "green" } },
        { "<leader>w", desc = "+Window", icon = { icon = "", color = "blue" } },
        { "<leader>u", desc = "+Undo", icon = { icon = "↺", color = "yellow" } },
      })

      ${lib.optionalString isDev ''
        wk.add({
          { "<leader>a", desc = "+Agentic", icon = { icon = "", color = "orange" } },
          { "<leader>g", desc = "+Git", icon = { cat = "filetype", name = "git" } },
          { "<leader>e", desc = "+Session", icon = { icon = "󰆓", color = "cyan" } },
        })
      ''}
    '';

    maps = {
      normal = {
        # Annoyances
        "q:" = {
          action = "<nop>";
        };
        # Buffer management
        "<leader>bd" = {
          action = "<cmd>bdelete<CR>";
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

        # Undo
        "<leader>ut" = {
          action = "<cmd>UndotreeToggle<CR>";
          desc = "Undo tree";
        };

        # Search
        "<leader>sr" = {
          action = "<cmd>GrugFar<CR>";
          desc = "Find and replace";
        };
      }
      // lib.optionalAttrs isDev {
        # Sessions
        "<leader>el" = {
          action = "<cmd>SessionManager load_session<CR>";
          desc = "Load session";
        };
        "<leader>ea" = {
          action = "<cmd>SessionManager load_last_session<CR>";
          desc = "Load last session";
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
