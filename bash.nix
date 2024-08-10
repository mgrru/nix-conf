{ ... }:

{
  programs.bash.shellInit = ''

  '';
  programs.bash.promptInit = ''
    clear_color="\e[0m"
    get_os_name() {
      os_name=$(uname -a)
      left_str="\e[0m\e[34;40;1m "
      right_str=" \e[0m"$clear_color
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
    get_git_branch() {
      git_branch_name=$(git branch --show-current 2>/dev/null)
      left_str="\e[34;7m\e[0m\e[37;44;1m "
      right_str=" \e[0m\[\e[34m\]"$clear_color
      if [ $git_branch_name ]
      then
        echo $left_str" "$git_branch_name$right_str
      fi
    }
    get_workspace() {
      left_str="\e[32;7m\e[0m\e[37;42;1m "
      right_str=" \e[0m\[\e[32m\]"$clear_color
      echo $left_str"\w"$right_str
    }
    get_user_name() {
      left_str="\e[36;40;7m$clear_color\e[34;46;1m "
      right_str=" $clear_color\e[36m"$clear_color

      user_str="\e[35m\u"
      at_str="\e[37m@"
      hostname_str="\e[31m\h"

      echo $left_str$user_str$at_str$hostname_str$right_str
    }
    PS1="$(get_os_name)$(get_user_name)$(get_git_branch)$(get_workspace) \e[37;2m=> 󰅒 \t =>  \s:\v$clear_color\n"'
  '';
}
