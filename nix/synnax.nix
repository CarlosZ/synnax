{ inputs, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    let
      mkPackage = pkgs.callPackage (
        { flavor }:
        (inputs.nvf.lib.neovimConfiguration {
          inherit pkgs;
          modules = [ ../neovim ];
          extraSpecialArgs =
            let
              isDev = flavor == "dev";
              isMin = flavor == "min";
            in
            {
              inherit isDev isMin;
              inherit inputs';
              flakeInputs = inputs;
            };
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
