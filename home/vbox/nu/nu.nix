{ ... }:

{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    loginFile.source = ./login.nu;
  };
  home.file.".config/nushell/git" = {
    source = ./git;
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
