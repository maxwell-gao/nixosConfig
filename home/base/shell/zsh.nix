{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      zmodload zsh/complist

      # Richer completion defaults without changing the rest of the shell UX.
      zstyle '::*' completer _extensions _complete _match _prefix _list
      zstyle ':completion:*' menu select
      zstyle ':completion:*' auto-description 'specify: %d'
      zstyle ':completion:*' completer _complete _ignored
      zstyle ':completion:*' complete-options true
      zstyle ':completion:*' group-name ""
      zstyle ':completion:*' keep-prefix true
      zstyle ':completion:*' list-dirs-first true
      zstyle ':completion:*' list-packed false
      zstyle ':completion:*' list-separator ' '
      zstyle ':completion:*' matcher-list \
        'm:{a-z}={A-Z}'
      zstyle ':completion:*' original true
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
      zstyle ':completion:*' show-completer true
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' squeeze-slashes true
      zstyle ':completion:*' use-cache true
      zstyle ':completion:*' verbose true
      zstyle ':completion:*' cache-path "${config.xdg.cacheHome}/zsh/zcompcache"
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*:messages' format '%F{yellow}%d%f'
      zstyle ':completion:*:warnings' format '%F{red}no matches for: %d%f'
      zstyle ':completion:*:default' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
      zstyle ':completion:*:*:kill:*:processes' command 'ps -u $USER -o pid,%cpu,%mem,etime,cmd'
      zstyle ':completion:*:*:ssh:*' tag-order hosts users
      zstyle ':completion:*:functions' ignored-patterns '_*'

      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
      bindkey "''${terminfo[kcuu1]}" up-line-or-beginning-search
      bindkey "''${terminfo[kcud1]}" down-line-or-beginning-search
      bindkey -M menuselect "^[[A" up-line-or-history
      bindkey -M menuselect "^[[B" down-line-or-history
      bindkey -M menuselect "^[[C" forward-char
      bindkey -M menuselect "^[[D" backward-char
      bindkey -M menuselect "''${terminfo[kcuu1]}" up-line-or-history
      bindkey -M menuselect "''${terminfo[kcud1]}" down-line-or-history
      bindkey -M menuselect "''${terminfo[kcuf1]}" forward-char
      bindkey -M menuselect "''${terminfo[kcub1]}" backward-char

      if ! command -v zed >/dev/null 2>&1; then
        for zed_candidate in zeditor zedit zed-editor; do
          if command -v "$zed_candidate" >/dev/null 2>&1; then
            alias zed="$zed_candidate"
            break
          fi
        done
      fi

      eval "$(starship init zsh)"
    '';

    shellAliases = {
      ll = "ls -l";
      g = "git";
      vim = "nvim";
    };
  };
}
