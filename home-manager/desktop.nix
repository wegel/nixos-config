{
  inputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      menu = "wofi --show run";
      bars = [{
        command = "waybar";
      }];
    };
  };

  programs.waybar.settings.bar_id = "bar-0";
  programs.waybar.settings.ipc = "true";
}