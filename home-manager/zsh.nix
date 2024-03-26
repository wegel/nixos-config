{
  inputs,
  lib,
  config,
  systemConfig,
  pkgs,
  ...
}: {

  programs = {
    zsh = {
      enable = true;
      dotDir = ".config/zsh";

      enableCompletion = true;
      syntaxHighlighting.enable = true;

      history = {
        save = 30000;
        size = 30000;
        path = "$HOME/.cache/zsh_history";
      };

      initExtra = ''
        zstyle ':completion:*' completer _complete _match _approximate
        zstyle ':completion:*:match:*' original only
        zstyle ':completion:*:approximate:*' max-errors 1 numeric
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

        export EDITOR=hx
      '';

      shellAliases = {
        ls = "eza -gl --git --color=auto --icons=auto";
        tree = "eza --tree";
        cat = "bat -P --style=plain";

        ip = "ip --color";
        ipb = "ip --color --brief";

        gitp = "git push";
        gits = "git status -sb";

        htop = "btm -b";

        open = "xdg-open";
        k = "kubectl";

        cleanup-nix = "sudo nix-collect-garbage -d";
        rln = "sudo nixos-rebuild switch --flake /home/wegel/nixos-config";
        rlh = "home-manager switch --flake /home/wegel/nixos-config";
        rlb = "rln;rlh";
      };
    };
  };
}