{ ... }:

{
  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.npm
      init-license=MIT
      registry=https://registry.npmmirror.com/
      color=true
    '';
  };
}
