{ lib, ... }: {
  programs = {
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = lib.mkDefault {
        
				format = lib.concatStrings [
					"$username"
					"$hostname"
					"$directory"
					"$git_branch"
					"$git_state"
					"$git_status"
					"$cmd_duration"
					"$line_break"
					"$python"
					"$character"
        ];

        #fill.symbol = " ";
        #hostname.ssh_symbol = "
        python.format = "([ $virtualenv]($style)) ";
        rust.symbol = " ";
        status.disabled = false;
        username.format = "[$user]($style)@";

        character = {
          success_symbol = "[❯](purple)";
          error_symbol = "[❯](red)";
          vicmd_symbol = "[❯](green)";
        };

        directory = {
          style = "blue";
        };

        docker_context.symbol = " ";

        git_branch = {
          symbol = " ";
          format = "[ $branch]($style)";
          style = "green";
        };

        git_status = {
          format = "[[( $conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
          style = "cyan";
          conflicted = "​=$count ";
          untracked = "​?$count ";
          modified = "​!$count ";
          staged = "​+$count ";
          renamed = "»$count ​";
          deleted = "​✘$count ";
          stashed = "≡";
        };

        git_state = {
          format = "\([$state( $progress_current/$progress_total)]($style)\) ";
          style = "bright-black";
        };

				cmd_duration = {
				  format = "[$duration]($style) ";
		 		  style = "yellow";
				};

        golang = {
          symbol = " ";
          format = "[$symbol$version](cyan bold) ";
        };

        nix_shell = {
          disabled = false;
          symbol = "❄️ ";
          format = "via [$symbol\($name\)]($style)";
        };
      };
    };
  };
}
