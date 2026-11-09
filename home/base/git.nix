{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "maxwell-gao";
        email = "maxwell-gao314@outlook.com";
      };

      init.defaultBranch = "main";

      credential."https://github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];

      credential."https://gist.github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
  };
}
