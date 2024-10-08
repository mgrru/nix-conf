{ pkgs, ... }:

{
  # 注意修改这里的用户名与用户目录
  home.username = "ru";
  home.homeDirectory = "/home/ru";

  imports = [
    # ../../sys-conf/hyprland/hyprland.nix
    # ../../sys-conf/hyprland/dunst.nix
    # ../../sys-conf/hyprland/waybar.nix
    # ./sys-conf/hyprland/wezterm.nix
    # ../../sys-conf/hyprland/kitty.nix

    ./java/java.nix
    ./bash/bash.nix
    ./npm/npm.nix
    ./yazi/yazi.nix
    ./nu/nu.nix
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


  home.packages = with pkgs; [
    # kitty
    # glfw
    # gtk3
    # mesa
    # mesa-utils
    # glxgears
    tree
    neofetch
    nixfmt-rfc-style
    nil
    rust-bin.stable.latest.default
    rust-analyzer
    clang
    # wl-clipboard
    # xclip
    xorg.xauth
    # xorg.xeyes
  ];

  programs.tmux={
    enable = true;
    terminal = "screen-256color";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      set -gq allow-passthrough on
    '';
  };

  programs.wezterm.enable = true;

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
