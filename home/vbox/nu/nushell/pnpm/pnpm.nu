# pnpm 别名
export alias pn = pnpm

# pnpm dev
export alias pd = pn vite

# 要在项目根目录下使用 需下载eslint
export alias plint = pn eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix --ignore-path .gitignore

# 要在项目根目录下使用 需下载prettier
export alias pfmt = pn prettier --write src/

# 下载
export alias pi = pn install

# 查看 pnpm 和 node 版本信息
export def pv [] {
  let nv = node -v
  let pv = pn -v
  $"node:($nv)\npnpm:($pv)"
}