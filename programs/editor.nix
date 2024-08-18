{ pkgs, ... }:

{
  programs = {
    nano.enable = false;
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      extraLuaPackages = ps: [ ps.magick ];
      extraPackages = ps: [ ps.imagemagick ];
    };
  };
}
