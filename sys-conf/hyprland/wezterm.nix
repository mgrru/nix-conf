{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'

      local config = wezterm.config_builder()

      config.font = wezterm.font 'CommitMono Nerd Font Propo'
      config.font_size = 10.5
      config.color_scheme = 'Tokyo Night Storm (Gogh)'

      config.hide_tab_bar_if_only_one_tab = true

      config.background ={
      	{
      		source = {
      		  File = '~/nix-conf/sys-conf/Hyprland/imgs/a.png',
      		},
      		repeat_x = "NoRepeat",
      		vertical_align = 'Middle',
      		repeat_y_size = '200%',
      		height = "Cover",
      		width = "Cover",
      		opacity = 0.19,
      	}
      }

      config.text_background_opacity = 1.0

      return config
    '';
  };
}
