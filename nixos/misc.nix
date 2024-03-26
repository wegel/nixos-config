{
  inputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {

  fonts.fontconfig.enable = true;
  programs.light.enable = true;

  # rtkit is optional but recommended
  security.rtkit.enable = true;

  time.timeZone = "${systemConfig.timezone}";
  i18n.defaultLocale = "${systemConfig.locale}";

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
