{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      mkPackage = pkgs.callPackage (
        { flavor }:
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ../neovim ];
          extraSpecialArgs = { inherit flavor; };
        }).neovim
      );
    in
    {
      packages = rec {
        default = dev;
        dev = mkPackage { flavor = "dev"; };
        min = mkPackage { flavor = "min"; };
      };
    };
}
