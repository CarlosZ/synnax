{
  description = "My New Package";

  inputs = {
    systems = {
      url = "github:nix-systems/default";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    import-tree.url = "github:vic/import-tree";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
    };
    llm-agents = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/llm-agents.nix";
    };
    agentic-nvim = {
      url = "github:carlos-algms/agentic.nvim/dcbb969167a9e24dc95fa7c213a28fbb1a600f13";
      flake = false;
    };
    diffview-nvim = {
      url = "github:dlyongemallo/diffview.nvim/v0.21";
      flake = false;
    };
    colorful-winsep-nvim = {
      url = "github:nvim-zh/colorful-winsep.nvim/84432d9966fafaa08dd9040c98b0011045d8e964";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } { imports = [ (import-tree ./nix) ]; };
}
