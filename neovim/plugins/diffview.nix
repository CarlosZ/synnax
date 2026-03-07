{ lib, isDev, ... }:
{
  vim = lib.mkIf isDev {
    # TODO: Replace with dlyongemallo/diffview.nvim
    utility.diffview-nvim = {
      enable = true;
    };
    maps = {
      normal = {
        "<leader>gd" = {
          action = "<cmd>DiffviewOpen<cr>";
          desc = "Open Diff View";
        };
        "<leader>gc" = {
          action = "<cmd>DiffviewClose<cr>";
          desc = "Close Diff View";
        };
        "<leader>gh" = {
          action = "<cmd>DiffviewFileHistory<cr>";
          desc = "Open History";
        };
        "<leader>gf" = {
          action = "<cmd>DiffviewFileHistory %<cr>";
          desc = "Open File History";
        };
      };
    };
  };
}
