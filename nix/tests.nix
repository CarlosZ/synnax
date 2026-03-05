{
  perSystem =
    { pkgs, ... }:
    {
      checks = {
        package-tests = pkgs.runCommand "package-tests" { } ''
          echo "FIXME: Running tests!"
          touch $out
        '';
      };
    };
}
