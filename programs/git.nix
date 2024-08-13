{ ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    # userName = "ru";
    # userEmail = "ru@fufu.moe";
    config = [
      {
        init = {
          defaultBranch = "main";
        };
        user = {
          name = "ru";
          email = "ru@fufu.moe";
          signingkey = "~/.ssh/id_ed25519";
        };
        commit = {
          gpgsign = true;
        };
        gpg = {
          format = "ssh";
        };
      }
    ];
  };
}
