{ ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        terminal = "ghostty -e";
        layer = "overlay";
        width = 40;
        lines = 12;
        prompt = "❯ ";
        icons-enabled = "yes";
        match-mode = "fzf";
      };

      colors = {
        background = "282828ff";
        text = "ebdbb2ff";
        match = "d79921ff";
        selection = "665c54ff";
        selection-text = "ebdbb2ff";
        selection-match = "fabd2fff";
        border = "d79921ff";
      };

      border = {
        width = 2;
        radius = 8;
      };
    };
  };
}
