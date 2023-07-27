{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    defaultKeymap = "viins";
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    cdpath = ["/tmp" "~/Documents"];

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignorePatterns = [ "l *" "ls *" ];
      ignoreSpace = true;
    };

    loginExtra = ''
      echo "loginExtra: loaded!"
    '';
    logoutExtra = ''
      echo "logoutExtra: loaded!"
    '';
    profileExtra = ''
      echo "profileExtra: loaded!"
    '';
    initExtraFirst = ''
      echo "initExtraFirst: loaded!"
    '';
    initExtra = ''
      echo "initExtra: loaded!"

      # list directory content when using 'cd'
      function cd () {
        builtin cd "$1";
        ls -ahlF --color=tty;
      }

      # cd into directory and show dir tree when created
      currentDir="$(pwd)"
      function mkcd () {
        mkdir -p "$1";
        builtin cd "$1";
        tree -L 3 -d "$currentDir";
      }

      # enter vim "normal mode" with 'jk' key combo
      bindkey -v
      bindkey 'jk' vi-cmd-mode
    '';
    envExtra = ''
      ENV_EXTRA_LAST_LOADED="$(date)"
    '';

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
          sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
        "z"
      ];
      theme = "robbyrussell";
    };

  };

}
