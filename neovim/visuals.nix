{ pkgs, ... }:
{
  vim = {
    visuals = {
      nvim-web-devicons.enable = true;
      highlight-undo.enable = true;
      rainbow-delimiters.enable = true;
    };
    ui = {
      borders = {
        enable = true;
        globalStyle = "rounded";
      };
      colorizer.enable = true;
      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
      };
      noice.enable = true;
    };
    lazy.plugins = {
      "nui.nvim" = {
        package = pkgs.vimPlugins.nui-nvim;
      };
      "vim-matchup" = {
        package = pkgs.vimPlugins.vim-matchup;
      };
    };
  };
}
