{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ru = {
    isNormalUser = true;
    description = "ru";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGDMgOItE9fReXLvuhCawIzjuy2fqTghEJQxINMdkEE ru@fufu.moe"
    ];
    packages = with pkgs; [
      tree
      neofetch
      nixfmt-rfc-style
      nil
      nodejs_20
      nodePackages_latest.pnpm
      pnpm-shell-completion
      rust-bin.stable.latest.default
    ];
  };
}
