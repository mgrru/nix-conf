{ ... }:

{
  programs.bash.shellInit = ''
    # rust代理
    export RUSTUP_DIST_SERVER="https://rsproxy.cn"
    export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
  '';
  programs.bash.shellAliases = {
    sudo = "sudo ";
    ls = "ls -F --color=auto";
    la = "ls -aF";
    ll = "ls -alF";
    grep = "grep --color=auto";
    pn = "pnpm";
    nrs = "sudo nixos-rebuild switch --flake .";
    ndev = "nix develop";
  };
  programs.bash.promptInit = ''
    clear_color="\e[0m"
    git_branch_name=""
    get_os_name() {
      os_name=$(uname -a)
      left_str="\e[0m\e[34;40;1m "
      right_str=$clear_color
      if [[ $os_name =~ "Arch" ]]
      then
        echo $left_str" "$right_str
      elif [[ $os_name =~ "WSL" ]]
      then
        echo $left_str" "$right_str
      elif [[ $os_name =~ "Nix" ]]
      then
        echo $left_str"󱄅 "$right_str
      elif [[ $os_name =~ "Windows" ]]
      then
        echo $left_str" "$right_str
      else
        echo $left_str" "$right_str
      fi
    }
    get_user_name() {
      left_str="\e[37;40;7m$clear_color\e[34;47;1m "
      right_str=" "$clear_color

      user_str="\e[31;47m\u"
      at_str="\e[31;47;1m@"
      hostname_str="\e[34;47m\h"

      echo $left_str$user_str$at_str$hostname_str$right_str
    }
    get_git_branch() {
      git_branch_name=$(git branch --show-current 2>/dev/null)
      left_str="\e[34;47;7m\e[0m\e[33;44m "
      right_str=" "$clear_color
      if [ $git_branch_name ]
      then
        echo $left_str" "$git_branch_name$right_str
      fi
    }
    get_workspace() {
      git_branch_name=$(git branch --show-current 2>/dev/null)
      if [ -z $git_branch_name ]
      then
        left_str="\e[31;47;7m\e[0m\e[37;41m "
        right_str=" \e[0m\[\e[31m\]"$clear_color
        echo $left_str"\w"$right_str
      else
        left_str="\e[31;44;7m\e[0m\e[37;41m "
        right_str=" \e[0m\[\e[31m\]"$clear_color
        echo $left_str"\w"$right_str
      fi
    }
    PROMPT_COMMAND='PS1="$(get_os_name)$(get_user_name)$(get_git_branch)$(get_workspace) \e[37;2m 󰅒 \t   \s:\v$clear_color\n>"'
  '';
}
