{ ... }:

{
  programs.nushell = {
    enable = true;
  };
  home.file = {
    ".config/nushell/git".source = ./git;
    ".config/nushell/login.nu".source = ./login.nu;
    ".config/nushell/env.nu".source = ./env.nu;
    ".config/nushell/config.nu".source = ./config.nu;
  };
  # home.file.".ssh" = {
  #   source = ./.ssh;
  #   # recursive = true;   # 递归整个文件夹
  #   # executable = true;  # 将其中所有文件添加「执行」权限
  # };

  programs.eza.enableNushellIntegration = true;
  programs.yazi.enableNushellIntegration = true;
  programs.oh-my-posh.enableNushellIntegration = false;
}
