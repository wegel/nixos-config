{
  inputs,
  outputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    inputs.nix-colors.homeManagerModule

    ./rice.nix
    ./desktop.nix
    ./user-packages.nix
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];

    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "${systemConfig.username}";
    homeDirectory = "/home/${systemConfig.username}";
  };

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName  = "Simon Labrecque";
    userEmail = "simon@wegel.ca";
    aliases = {
      ci = "commit";
      co = "checkout";
      s = "status";
      p = "pull";
      P = "push";
    };
    extraConfig = {
      push = { autoSetupRemote = true; };
    };
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
