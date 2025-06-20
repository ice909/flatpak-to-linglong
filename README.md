# flatpak-to-linglong

flatpak转linglong自动化脚本

## 脚本说明

### build.sh

- 说明：使用ll-builder构建 linglong layer。

### check.sh

- 参数：<REPO_URL> <REPO_NAME> <APP_ID> \<VERSION>
- 说明：检查仓库中是否已经存在指定 APP_ID 和版本，存在则跳过后续所有步骤。
- 用法示例：./check.sh [https://repo-dev.linyaps.org.cn] dev com.example.App 1.0.0

### push.sh

- 参数：<REPO_URL> <REPO_NAME>
- 说明：将 ${APP_ID}/layer 目录下的 layer 文件推送到指定仓库。
- 用法示例：./push.sh [https://repo-dev.linyaps.org.cn] dev

### test.sh

- 参数：<APP_ID>
- 说明：安装 layer 并运行，简单测试运行情况，最后卸载并清理。
- 用法示例：./test.sh com.example.App
