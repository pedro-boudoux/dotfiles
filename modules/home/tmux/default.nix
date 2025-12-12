{pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];

    extraConfig = ''

      # smart splits detection
    # checks if the current pane is running vim/nvim
    is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
        | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

    # nav bindings
    bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
    bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
    bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
    bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

    # resize bindings
    bind-key -n M-h if-shell "$is_vim" 'send-keys M-h' 'resize-pane -L 3'
    bind-key -n M-j if-shell "$is_vim" 'send-keys M-j' 'resize-pane -D 3'
    bind-key -n M-k if-shell "$is_vim" 'send-keys M-k' 'resize-pane -U 3'
    bind-key -n M-l if-shell "$is_vim" 'send-keys M-l' 'resize-pane -R 3'

    # copy mode consistency
    bind-key -T copy-mode-vi 'C-h' select-pane -L
    bind-key -T copy-mode-vi 'C-j' select-pane -D
    bind-key -T copy-mode-vi 'C-k' select-pane -U
    bind-key -T copy-mode-vi 'C-l' select-pane -R

    # rage-quit pane
    bind-key x kill-pane

    # splits
    bind-key | split-window -h -c "#{pane_current_path}"
    bind-key - split-window -v -c "#{pane_current_path}"

    # 'c' for new window
    bind-key c new-window -c "#{pane_current_path}"
          '';

  };
}
