{ pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "ru";
  home.homeDirectory = "/home/ru";

  imports = [
    ./sys-conf/Hyprland/hyprland.nix
    ./sys-conf/Hyprland/waybar.nix
    ./sys-conf/Hyprland/wezterm.nix
  ];

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = _: true;
    };
  };

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".ssh" = {
  #   source = ./.ssh;
  #   # recursive = true;   # 递归整个文件夹
  #   # executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # 通过 home.packages 安装一些常用的软件
  # 这些软件将仅在当前用户下可用，不会影响系统级别的配置
  # 建议将所有 GUI 软件，以及与 OS 关系不大的 CLI 软件，都通过 home.packages 安装
  # home.packages = with pkgs; [ wezterm ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = with pkgs; [ imagemagick ];
  };

  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
