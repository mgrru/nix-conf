{ ... }:

{
  programs.npm = {
    enable = true;
    npmrc = ''
      prefix = ''${HOME}/.npmrc
      init-license=MIT
      registry=https://registry.npmmirror.com/
      color=true
    '';
  };
}
