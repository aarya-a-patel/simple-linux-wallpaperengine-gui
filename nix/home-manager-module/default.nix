flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.simple-wallpaper-engine;
in {
  options.services.simple-wallpaper-engine = {
    enable = lib.mkEnableOption "Wallpaper service (user systemd)";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.simpl-wallpaper-engine = {
      Unit = {
        Description = "Set wallpaper";
        After = cfg.after;
        Wants = cfg.wants;
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "simple";
        ExecStart = "${lib.getExe flake.packages.${pkgs.system}.default} --background";

        Restart = "always";
        RestartSec = 10;

        Environment = [
          "XDG_RUNTIME_DIR=%t"
        ];
      };

      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
