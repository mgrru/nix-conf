use pnpm.nu *

# 自动下载elplus,axios,需要传个项目名称
export def vue [project_name] {
  pnpm create vue@latest $project_name
  cd $project_name
  pi axios element-plus @element-plus/icons-vue
}