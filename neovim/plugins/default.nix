{
  imports = [
    ./agentic.nix
    ./blink-cmp.nix
    ./colorful-winset.nix
    ./diffview.nix
    ./git.nix
    ./langs.nix
    ./lsp.nix
    ./lualine.nix
    ./smart-splits.nix
    ./snacks.nix
  ];
  vim = {
    treesitter = {
      enable = true;
      fold = true;
    };
  };
}
