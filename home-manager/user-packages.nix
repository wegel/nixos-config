{
  inputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {

  home.packages = with pkgs.unstable; [
    grim slurp wl-clipboard mako mako foot swaybg wofi waybar
    pinta xfce.mousepad xdragon gnome.nautilus
    xorg.xauth xorg.xhost
    google-chrome
    ffmpeg mpv vlc
    lazygit meld gnumake

    helix neovim
    podman podman-compose nvidia-docker
    vscode rust-analyzer
    nodePackages.bash-language-server gopls nodePackages.vscode-json-languageserver
    python311Packages.python-lsp-server yaml-language-server taplo

    noto-fonts noto-fonts-emoji noto-fonts-extra hack-font
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
  ] ++ [ pkgs.firefox ];

}