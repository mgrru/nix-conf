{ ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ru = {
    isNormalUser = true;
    description = "ru";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGDMgOItE9fReXLvuhCawIzjuy2fqTghEJQxINMdkEE ru@fufu.moe"
    ];
  };
}
