{ config, ... }:

{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
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
    };
  };
}
