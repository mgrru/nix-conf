{ ... }:

{
  programs.nushell = {
    enable = true;
    configFile.source = ./config.nu;
    envFile.source = ./env.nu;
    loginFile.source = ./login.nu;
  };

  programs.eza.enableNushellIntegration = true;
  programs.yazi.enableNushellIntegration = true;
  programs.oh-my-posh.enableNushellIntegration = false;
}
