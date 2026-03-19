{ inputs, ... }:
{
  perSystem =
    { pkgs, inputs', ... }:
    let
      mkNeovim =
        flavor:
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

      mkPackage = pkgs.callPackage (
        { flavor }:
        let
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
            ln -s ${mkNeovim flavor}/bin/nvim $out/bin/${pname}
          ''
      );

      mkPrintConfig =
        { flavor }:
        let
          pname = "print-config-${flavor}";
        in
        pkgs.runCommand pname
          {
            inherit pname;
            version = "0.0.1";
          }
          ''
            mkdir -p $out/bin/let
            ln -s ${mkNeovim flavor}/bin/nvf-print-config $out/bin/nvf-print-config
          '';
    in
    {
      packages = rec {
        default = dev;
        dev = mkPackage { flavor = "dev"; };
        print-dev = mkPrintConfig { flavor = "dev"; };
        min = mkPackage { flavor = "min"; };
        print-min = mkPrintConfig { flavor = "min"; };
      };
    };
}
