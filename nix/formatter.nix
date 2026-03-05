{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";

      programs = {
        nixfmt = {
          enable = true;
          strict = true;
        };
        shfmt.enable = true;
      };

      settings = {
        global.excludes = [ "*.{age,gif,png,svg,env,envrc,gitignore,tmTheme,sublime-syntax,theme}" ];
      };
    };
  };
}
