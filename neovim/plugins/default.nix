{
  imports = [
    ./blink-cmp.nix
    ./diffview.nix
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
