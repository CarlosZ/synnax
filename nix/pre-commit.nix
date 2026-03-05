{ inputs, ... }:
{
  imports = [ inputs.pre-commit-hooks.flakeModule ];

  perSystem =
    { pkgs, ... }:
    {
      pre-commit = {
        settings = {
          package = pkgs.prek;
          hooks = {
            # Nix
            deadnix.enable = true;
            flake-checker.enable = true;
            nil.enable = true;
            statix.enable = true;

            # Shell
            shellcheck.enable = true;
          };
        };
      };
    };
}
