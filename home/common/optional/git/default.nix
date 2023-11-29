{ pkgs, ... }:

{

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Klaasjan Maas";
    userEmail = "klaasjan.maas@outlook.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = "true";
      fetch.prune = "true";
      diff.colorMoved = "zebra";
    };
    ignores = [ ".direnv" "result" ];
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
    pkgs.tig  # Text-mode interface for git
  ];

}
