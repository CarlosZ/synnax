{ inputs, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    let
      mkPackage = pkgs.callPackage (
        { flavor }:
        let
          pkg =
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
            }).neovim;
          pname = "synnax-${flavor}";
        in
        pkgs.runCommand pname
          {
            inherit pname;
            version = "0.0.1";
            meta = {
              license = pkgs.lib.licenses.mit;
              mainProgram = pname;
            };
          }
          ''
            mkdir -p $out/bin
            ln -s ${pkg}/bin/nvim $out/bin/${pname}
          ''
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
