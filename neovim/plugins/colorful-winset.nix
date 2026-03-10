{ pkgs, ... }:
let
  colorfulWinsepNvimPkg = pkgs.vimUtils.buildVimPlugin {
    name = "colorful-winsep-nvim";
    src = pkgs.fetchFromGitHub {
      owner = "nvim-zh";
      repo = "colorful-winsep.nvim";
      rev = "84432d9966fafaa08dd9040c98b0011045d8e964";
      hash = "sha256-xZKDP/9iG2+tt8nqNpirvCe5olNj/jLYrVV9D6o+UXk=";
    };
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
