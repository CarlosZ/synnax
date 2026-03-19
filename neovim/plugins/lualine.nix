{ lib, ... }:
let
  inherit (lib.generators) mkLuaInline;
in
{
  vim.statusline.lualine = {
    enable = true;
    activeSection = {
      z = [
        ''
          {
            "",
            draw_empty = true,
            separator = { left = '', right = '' }
          }
        ''
        ''
          {"location"}
        ''
      ];
    };
    setupOpts = {
      tabline = {
        lualine_a = [
          (mkLuaInline ''
            {
              "buffers",
              show_filename_only = false,
              mode = 2,
            }
          '')
        ];
        lualine_z = [
          (mkLuaInline ''
            {
              "tabs",
              cond = function() return #vim.api.nvim_list_tabpages() > 1 end,
            }
          '')
        ];
      };
    };
  };
}
