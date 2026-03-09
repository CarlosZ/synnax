{
  imports = [
    ./blink-cmp.nix
    ./diffview.nix
    ./git.nix
    ./langs.nix
    ./lsp.nix
    ./lualine.nix
    ./snacks.nix
  ];
  vim = {
    treesitter = {
      enable = true;
      fold = true;
    };
  };
}
