{
  inputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {
	environment.systemPackages = with pkgs; [
	    zellij starship
	    wget
	    curl
	    ripgrep fzf htop
	    zsh dool neofetch screen tig unzip tree zoxide bat eza duf broot
	    fd lsd bottom bmon procs btop

	    dconf
	    helix neovim
	  ];
}
