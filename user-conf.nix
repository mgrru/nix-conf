{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ru = {
    isNormalUser = true;
    description = "ru";
    extraGroups =
      [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGDMgOItE9fReXLvuhCawIzjuy2fqTghEJQxINMdkEE ru@fufu.moe"
    ];
    packages = with pkgs; [
      neofetch
      nixfmt-classic
      nil
      jdk21_headless
      maven
      nodejs_20
    ];
  };

  programs.npm = {
    enable = true;
    package = pkgs.nodePackages.pnpm;
    npmrc = ''
      prefix = ''${HOME}/.pnpm
      init-license=MIT
      init-author-url=https://registry.npmmirror.com
      color=true
    '';
  };
}
