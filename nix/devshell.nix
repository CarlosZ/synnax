{
  perSystem =
    { pkgs, config, ... }:
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          config.pre-commit.settings.enabledPackages
          config.pre-commit.settings.package
          pkgs.stylua
        ];

        shellHook = ''
          ${config.pre-commit.shellHook}

          printf '\n\n🌌🛰️🌌 \033[1;31mWelcome to the Synnax DevShell\033[0m 🌌🛰️🌌\n\n'
        '';
      };
    };
}
