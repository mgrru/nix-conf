{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: Source Code Pro;
      }
      window#waybar {
        background: #16191C;
        color: #AAB2BF;
      }
      #workspaces button {
        padding: 0 5px;
      }
    '';
    settings = [
      {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          output = [
            "eDP-1"
            "HDMI-A-1"
          ];
          modules-left = [
            "hyprland/workspaces"
            "hyprland/mode"
            "wlr/taskbar"
          ];
          modules-center = [
            "hyprland/window"
            "custom/hello-from-waybar"
          ];
          modules-right = [
            "mpd"
            "custom/mymodule#with-css-id"
            "temperature"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };
          "custom/hello-from-waybar" = {
            format = "hello {}";
            max-length = 40;
            interval = "once";
            exec = pkgs.writeShellScript "hello-from-waybar" ''
              echo "from within waybar"
            '';
          };
        };
      }
    ];
  };
}
