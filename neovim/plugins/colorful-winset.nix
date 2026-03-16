{ flakeInputs, pkgs, ... }:
let
  colorfulWinsepNvimPkg = pkgs.vimUtils.buildVimPlugin {
    name = "colorful-winsep-nvim";
    src = flakeInputs.colorful-winsep-nvim;
  };
in
{
  vim = {
    extraPlugins.colorful-winsep-nvim = {
      package = colorfulWinsepNvimPkg;
      setup = ''
        require('colorful-winsep').setup({
          animate = {
            enabled = false,
          },
        })
      '';
    };
  };
}
