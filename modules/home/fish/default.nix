{config, pkgs, ...}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch --flake \"/home/pedro/dotfiles/home-manager#pedro\" --impure";
      nrs = "sudo nixos-rebuild switch";
      cat = "bat --theme=gruvbox-dark";
    };
    interactiveShellInit = ''
      set -g fish_greeting
      fastfetch
      
      if not set -q TMUX
        tmux attach -t main; or tmux new -s main
      end

      # Function to add padding when entering terminal
      function __kitty_add_padding --on-event fish_prompt
        if test -n "$KITTY_WINDOW_ID"
          kitty @ --to unix:/tmp/kitty set-window-padding 10 20 2>/dev/null
        end
      end

      # Function to remove padding when running a command
      function __kitty_remove_padding --on-event fish_preexec
        if test -n "$KITTY_WINDOW_ID"
          kitty @ --to unix:/tmp/kitty set-window-padding 0 0 2>/dev/null
        end
      end
    '';
  };
}
