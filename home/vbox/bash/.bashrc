#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# 设置默认终端文本编辑器
export EDITOR='nvim'

# rust代理
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# 设置sudo别名方便跟其他别名组合使用
# 别名结尾留空可以组合其他别名一起使用
alias sudo='sudo '
alias grep='grep --color=auto'
alias l='eza --color=always --icons -GF -a -T -L 3'
alias la='eza --color=always --icons -aF'
alias ll='eza --color=always --icons -alF'
alias ls='eza -F --color=always --icons'

# 简化nix的命令
alias ndev='nix develop'
alias nrs='sudo nixos-rebuild switch --flake .'

# pnpm
alias pn='pnpm '
alias pvue='pnpm create vue@latest'
alias pi='pnpm install '
alias pdev='pnpm dev'
alias pfmt='pnpm format '
alias plint='pnpm lint '

# nvim
alias vi='nvim '
alias vim='nvim '

# 通用命令
alias ..='cd ..'
alias i='install '

# windows相关命令
alias scc='scoop '
alias ui='uninstall '

# 管理别名的工具(其实是类似makefile的构建工具)
# alias cm='cargo make --makefile ~/.cm/Makefile.toml '
alias j='just '
alias jl='just -l'
complete -F _just -o bashdefault -o default j
# for recipe in `just --justfile ~/.config/justfile/.justfile --summary`; do
#   alias $recipe="just --justfile ~/.config/justfile/.justfile --working-directory . $recipe"
# done


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
  elif [[ $os_name =~ "MINGW" ]]
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
PROMPT_COMMAND='PS1="$(get_os_name)$(get_user_name)$(get_git_branch)$(get_workspace)\n$ "'










_just() {
    local i cur prev words cword opts cmd
    COMPREPLY=()

    # Modules use "::" as the separator, which is considered a wordbreak character in bash.
    # The _get_comp_words_by_ref function is a hack to allow for exceptions to this rule without
    # modifying the global COMP_WORDBREAKS environment variable.
    if type _get_comp_words_by_ref &>/dev/null; then
        _get_comp_words_by_ref -n : cur prev words cword
    else
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        words=$COMP_WORDS
        cword=$COMP_CWORD
    fi

    cmd=""
    opts=""

    for i in ${words[@]}
    do
        case "${cmd},${i}" in
            ",$1")
                cmd="just"
                ;;
            *)
                ;;
        esac
    done

    case "${cmd}" in
        just)
            opts="-E -n -g -f -q -u -v -d -c -e -l -s -h -V --check --chooser --clear-shell-args --color --command-color --dotenv-filename --dotenv-path --dry-run --dump-format --global-justfile --highlight --justfile --list-heading --list-prefix --list-submodules --no-aliases --no-deps --no-dotenv --no-highlight --quiet --set --shell --shell-arg --shell-command --timestamp --timestamp-format --unsorted --unstable --verbose --working-directory --yes --changelog --choose --command --completions --dump --edit --evaluate --fmt --groups --init --list --man --show --summary --variables --help --version [ARGUMENTS]..."
                if [[ ${cur} == -* ]] ; then
                    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                    return 0
                elif [[ ${cword} -eq 1 ]]; then
                    local recipes=$(just --summary 2> /dev/null)

                    if echo "${cur}" | \grep -qF '/'; then
                        local path_prefix=$(echo "${cur}" | sed 's/[/][^/]*$/\//')
                        local recipes=$(just --summary 2> /dev/null -- "${path_prefix}")
                        local recipes=$(printf "${path_prefix}%s\t" $recipes)
                    fi

                    if [[ $? -eq 0 ]]; then
                        COMPREPLY=( $(compgen -W "${recipes}" -- "${cur}") )
                        if type __ltrim_colon_completions &>/dev/null; then
                            __ltrim_colon_completions "$cur"
                        fi
                        return 0
                    fi
                fi
            case "${prev}" in
                --chooser)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --color)
                    COMPREPLY=($(compgen -W "auto always never" -- "${cur}"))
                    return 0
                    ;;
                --command-color)
                    COMPREPLY=($(compgen -W "black blue cyan green purple red yellow" -- "${cur}"))
                    return 0
                    ;;
                --dotenv-filename)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dotenv-path)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -E)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --dump-format)
                    COMPREPLY=($(compgen -W "json just" -- "${cur}"))
                    return 0
                    ;;
                --justfile)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -f)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --list-heading)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --list-prefix)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --set)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --shell-arg)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --timestamp-format)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --working-directory)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -d)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --command)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --completions)
                    COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
                    return 0
                    ;;
                --list)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -l)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --show)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                -s)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
    esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
    complete -F _just -o nosort -o bashdefault -o default just
else
    complete -F _just -o bashdefault -o default just
fi

