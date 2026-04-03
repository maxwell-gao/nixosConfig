{ ... }:

let
  # The optional "via" format used by most language modules.
  # Wrapping in ( ) makes the entire segment disappear when nothing is detected.
  via = "(via [$symbol($version )]($style))";

  # Modules that all share the same `via` format string.
  viaModules = [
    "bun"
    "c"
    "cpp"
    "cmake"
    "cobol"
    "crystal"
    "daml"
    "dart"
    "deno"
    "elm"
    "erlang"
    "fennel"
    "fortran"
    "gleam"
    "golang"
    "haskell"
    "helm"
    "java"
    "julia"
    "kotlin"
    "lua"
    "nim"
    "nodejs"
    "opa"
    "perl"
    "php"
    "purescript"
    "quarto"
    "red"
    "rlang"
    "ruby"
    "rust"
    "scala"
    "swift"
    "typst"
    "vagrant"
    "vlang"
    "xmake"
    "zig"
  ];
in

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      shell = {
        disabled = false;
        format = "[$symbol]($style) ";
        style = "bold italic cyan";
        fish_indicator = "󰈺 ";
        zsh_indicator = "󱆃 ";
        bash_indicator = " ";
        powershell_indicator = " ";
      };

      # Modules with unique formats
      buf.format = "(with [$symbol($version )]($style))";
      package.format = "(is [$symbol$version]($style) )";
      dotnet.format = "(via [$symbol($version )(🎯 $tfm )]($style))";
      raku.format = "(via [$symbol($version-$vm_version )]($style))";

      # Backslash-escaped parens in the display string — '' strings keep \ literal
      elixir.format = ''(via [$symbol($version \(OTP $otp_version\) )]($style))'';
      ocaml.format = ''(via [$symbol($version )(\($switch_indicator$switch_name\) )]($style))'';

      # $ must be escaped in regular Nix strings to avoid interpolation
      python.format = "(via [\${symbol}\${pyenv_prefix}(\${version} )(\\($virtualenv\\) )]($style))";

    } // builtins.listToAttrs (map
      (name: {
        inherit name;
        value.format = via;
      })
      viaModules);
  };
}
