{
  pkgs,
  lib,
  isDev,
  ...
}:
let
  diffviewNvimPkg =
    (pkgs.vimUtils.buildVimPlugin {
      name = "diffview-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "dlyongemallo";
        repo = "diffview.nvim";
        tag = "v0.21";
        hash = "sha256-mlp7NQhnPD4uJlP7foIhD5EvQBrVHH4tLgXqy7IvgsI=";
      };
      nvimSkipModules = [
        "diffview.api.views.diff.diff_view"
        "diffview.job"
        "diffview.multi_job"
        "diffview.scene.layouts.diff_2"
        "diffview.scene.layouts.diff_2_hor"
        "diffview.scene.layouts.diff_2_ver"
        "diffview.scene.layouts.diff_3"
        "diffview.scene.layouts.diff_3_hor"
        "diffview.scene.layouts.diff_3_mixed"
        "diffview.scene.layouts.diff_3_ver"
        "diffview.scene.layouts.diff_4"
        "diffview.scene.layouts.diff_4_mixed"
        "diffview.scene.views.diff.diff_view"
        "diffview.scene.views.file_history.file_history_panel"
        "diffview.scene.views.file_history.option_panel"
        "diffview.scene.window"
        "diffview.ui.panel"
        "diffview.ui.panels.commit_log_panel"
        "diffview.ui.panels.help_panel"
        "diffview.vcs.adapter"
        "diffview.vcs.adapters.git.init"
        "diffview.vcs.adapters.hg.init"
        "diffview.vcs.adapters.jj.init"
        "diffview.vcs.adapters.p4.init"
      ];

      doInstallCheck = true;
    }).overrideAttrs
      (_: {
        name = "diffview-nvim";

      });
in
{
  config = lib.mkIf isDev {
    vim = {
      lazy.plugins.diffview-nvim.package = lib.mkForce diffviewNvimPkg;
      utility.diffview-nvim = {
        enable = true;
      };
    };

    synnax.keys = {
      Git = {
        rootKey = "<leader>g";
        maps = [
          {
            key = "d";
            mode = [ "n" ];
            action = "<cmd>DiffviewOpen<cr>";
            desc = "Open Diff View";
          }
          {
            key = "c";
            mode = [ "n" ];
            action = "<cmd>DiffviewClose<cr>";
            desc = "Close Diff View";
          }
          {
            key = "h";
            mode = [ "n" ];
            action = "<cmd>DiffviewFileHistory<cr>";
            desc = "Open History";
          }
          {
            key = "f";
            mode = [ "n" ];
            action = "<cmd>DiffviewFileHistory %<cr>";
            desc = "Open File History";
          }
        ];
      };
    };
  };
}
