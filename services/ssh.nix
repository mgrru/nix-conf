{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      X11Forwarding = true;
    };
    extraConfig = ''
      X11DisplayOffset 10
    '';
  };

  services.sshd.enable = true;
  programs.ssh = {
    startAgent = true;
    forwardX11 = true;
    hostKeyAlgorithms = [
      "ssh-ed25519"
      "ssh-rsa"
    ];
  };
}
