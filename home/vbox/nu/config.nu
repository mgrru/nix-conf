$env.config = {
    # main configuration
}
$env.EDITOR = 'nvim'

alias ll = ls -l
alias la = ls -a

# sudo nixos-rebuild switch 不带默认git信息
def nrs [msg: string, path_or_both: string = ., host?: string] {
  git add .
  git commit -m $msg
  if $host == null {
    sudo nixos-rebuild switch --flake $"($path_or_both)"
  } else {
    sudo nixos-rebuild switch --flake $"($path_or_both)#($host)"
  }
}

# sudo nixos-rebuild switch 带默认git信息
def gnrs [msg: string = "upd", path_or_both: string = ., host?: string] {
  git add .
  git commit -m $msg

  if $host == null {
    sudo nixos-rebuild switch --flake $"($path_or_both)"
  } else {
    sudo nixos-rebuild switch --flake $"($path_or_both)#($host)"
  }
}


def greet1 [name = 'ru', ...ex] {
  $"hello ($name) ($ex)"
}


def greet2 [name?: string = "ru"] {
  $"hello ($name)"
}

def greet3 [name: string = "ru"] {
  $"hello ($name)"
}

def greet4 [name: string] {
  $"hello ($name)"
}
