$env.config = {
    # main configuration
}
$env.EDITOR = 'nvim'

alias ll = ls -l
alias la = ls -a

def greet [...name: string] {
  let res = "hello ";
  for $i in $name {
    $"($res) ($i)"
  }
  print $res
}

def gnrs [msg: string] {
  git add .
  if $msg == null {
    git commit -m 'upd'
  } else {
    git commit -m $msg
  }
  sudo nixos-rebuild switch --flake .
}