{ lib, isDev, ... }:
let
  inherit (lib.nvim.dag) entryAfter;
in
{
  vim = lib.mkIf isDev {
    git.gitsigns = {
      enable = true;
      mappings = {
        nextHunk = "<leader>gn";
        previousHunk = "<leader>gp";
        toggleBlame = "<leader>gb";
        toggleDeleted = "<leader>gD";
        stageHunk = null;
        undoStageHunk = null;
        resetHunk = null;
        stageBuffer = null;
        resetBuffer = null;
        previewHunk = null;
        blameLine = null;
        diffThis = null;
        diffProject = null;
      };
    };
    luaConfigRC.gitsigns = entryAfter [ "gitsigns" ] ''
      local wk = require("which-key")
      wk.add({
        { "<leader>h", hidden = true },
      })
    '';
  };
}
