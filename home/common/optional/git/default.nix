{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user = {
        name = "Klaasjan Maas";
        email = "klaasjan@majok.dev";
      };
      branch = {
        autoSetupRemote = "true";
        autoSetupMerge = "simple";
      };
      init.defaultBranch = "main";
      pull.rebase = "true";
      push.default = "simple";
      fetch.prune = "true";
      diff.colorMoved = "zebra";
    };
    ignores = [
      ".direnv"
      "result"
    ];
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.pagers = [
        { "externalDiffCommand" = "difft --color=always"; }
      ];
    };
  };

  home.shellAliases = {
    gs = "git status";
    ga = "git add --verbose";
    gapa = "git add --patch";
    gc = "git commit --verbose";
    gl = "git log";
    ggraph = "git log --decorate --oneline --graph";
  };

  home.packages = [
    pkgs.tig # Text-mode interface for git
    pkgs.difftastic # Syntax-aware diff
  ];

}
