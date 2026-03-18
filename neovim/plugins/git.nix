{
  config,
  lib,
  isDev,
  ...
}:
let
  inherit (lib.nvim.dag) entryAfter;
in
{
  vim = lib.mkIf isDev {
    git.gitsigns = {
      enable = true;
      mappings = lib.mapAttrs (_: _: null) config.vim.git.gitsigns.mappings;
    };

    luaConfigRC.gitsigns = entryAfter [ "gitsigns" ] ''
      local wk = require("which-key")
      wk.add({
        { "<leader>h", hidden = true },
      })
    '';
  };

  synnax.keys = lib.mkIf isDev {
    Git = {
      rootKey = "<leader>g";
      icon = "󰊢";
      iconColor = "red";
      maps = [
        {
          key = "D";
          mode = [ "n" ];
          action = "require('gitsigns').toggle_deleted";
          desc = "Toggle deleted hunks";
          lua = true;
        }
        {
          key = "b";
          mode = [ "n" ];
          action = "require('gitsigns').toggle_current_line_blame";
          desc = "Toggle blame";
          lua = true;
        }
        {
          key = "n";
          mode = [ "n" ];
          action = ''
            function()
              if vim.wo.diff then
                return "<leader>gn"
              end

              vim.schedule(function()
                require('gitsigns').next_hunk()
              end)

              return "<Ignore>"
            end
          '';
          desc = "Next hunk";
          expr = true;
          lua = true;
        }
        {
          key = "p";
          mode = [ "n" ];
          action = ''
            function()
              if vim.wo.diff then
                return "<leader>gp"
              end

              vim.schedule(function()
                require('gitsigns').prev_hunk()
              end)

              return "<Ignore>"
            end
          '';
          desc = "Previous hunk";
          expr = true;
          lua = true;
        }
        {
          key = "l";
          mode = [ "n" ];
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
          lua = true;
        }
        {
          key = "s";
          mode = [ "n" ];
          action = ''
            function()
              require("snacks").picker.git_status()
            end
          '';
          desc = "Modified files";
          lua = true;
        }
      ];
    };
  };
}
