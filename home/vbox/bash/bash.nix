{ ... }:

{
  home.file.".bashrc".source = ./.bashrc;
  home.file.".bash_profile".source = ./.bash_profile;
  programs.bash = {
    enable = false;
    historyIgnore = [
      "ls"
      "cd"
      "exit"
    ];
  };
}
