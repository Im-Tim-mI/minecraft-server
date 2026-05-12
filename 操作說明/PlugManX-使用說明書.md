# ============================================
# PlugManX 插件管理器 使用說明書
# ============================================
# 
# PlugManX 讓你可以在不重啟伺服器的情況下
# 載入、卸載、重載、更新插件
#
# GitHub: https://github.com/TheBlackEntity/PlugManX
#
# ============================================


## 目錄

1. 安裝 PlugManX
2. 基本指令
3. 載入新插件
4. 卸載插件
5. 重載插件
6. 更新插件
7. 檢查插件更新
8. 查看插件資訊
9. 常見問題
10. 注意事項


# ============================================
# 1. 安裝 PlugManX
# ============================================

## 下載並安裝

```bash
cd ~/Desktop/minecraft-server/plugins
wget -O PlugManX.jar "https://github.com/TheBlackEntity/PlugManX/releases/latest/download/PlugManX.jar"
sudo systemctl restart minecraft
```

## 確認安裝成功

在遊戲內輸入：
```
/plugins
```

看到 PlugManX 顯示綠色即安裝成功。


# ============================================
# 2. 基本指令
# ============================================

| 指令                        | 功能             |
|----------------------------|------------------|
| /plugman help              | 顯示幫助選單       |
| /plugman list              | 列出所有插件       |
| /plugman info <插件>        | 查看插件詳細資訊   |
| /plugman load <插件>        | 載入插件          |
| /plugman unload <插件>      | 卸載插件          |
| /plugman reload <插件>      | 重載插件          |
| /plugman restart <插件>     | 重啟插件（卸載+載入）|
| /plugman enable <插件>      | 啟用插件          |
| /plugman disable <插件>     | 停用插件          |
| /plugman check <插件>       | 檢查插件是否有更新  |
| /plugman check all         | 檢查所有插件更新    |
| /plugman lookup <指令>      | 查詢指令屬於哪個插件 |
| /plugman usage <插件>       | 查看插件的指令用法   |
| /plugman dump              | 匯出插件列表到檔案   |

## 指令別名

- /plugman = /pm = /plugmanx


# ============================================
# 3. 載入新插件（不重啟伺服器）
# ============================================

## 步驟 1：下載插件到 plugins 資料夾

方法 A - 使用終端機：
```bash
cd ~/Desktop/minecraft-server/plugins
wget -O 插件名稱.jar "下載連結"
```

方法 B - 手動上傳：
將 .jar 檔案放到 plugins 資料夾

## 步驟 2：在遊戲內載入

```
/plugman load 插件名稱
```

## 範例：載入 Vault

```bash
# 終端機下載
cd ~/Desktop/minecraft-server/plugins
wget -O Vault.jar "https://github.com/MilkBowl/Vault/releases/download/1.7.3/Vault.jar"
```

```
# 遊戲內載入
/plugman load Vault
```

## 範例：載入 DiscordSRV

```bash
cd ~/Desktop/minecraft-server/plugins
wget -O DiscordSRV.jar "https://github.com/DiscordSRV/DiscordSRV/releases/latest/download/DiscordSRV-Build-SNAPSHOT.jar"
```

```
/plugman load DiscordSRV
```


# ============================================
# 4. 卸載插件
# ============================================

## 步驟 1：卸載插件

```
/plugman unload 插件名稱
```

## 步驟 2：（可選）刪除插件檔案

```bash
rm ~/Desktop/minecraft-server/plugins/插件名稱.jar
```

## 範例：卸載 Skript

```
/plugman unload Skript
```

```bash
# 如果要完全移除
rm ~/Desktop/minecraft-server/plugins/Skript.jar
rm -rf ~/Desktop/minecraft-server/plugins/Skript/
```

## 注意事項

- 卸載後插件的指令將無法使用
- 某些插件可能無法完全卸載（需要重啟）
- 建議先停用再卸載：/plugman disable 插件 → /plugman unload 插件


# ============================================
# 5. 重載插件
# ============================================

## 重載單個插件

重新讀取插件的配置文件：
```
/plugman reload 插件名稱
```

## 重啟插件

完全重啟插件（卸載後重新載入）：
```
/plugman restart 插件名稱
```

## 重載所有插件

```
/plugman reload all
```

## 何時使用？

| 情況                 | 使用指令                    |
|---------------------|---------------------------|
| 修改了 config.yml    | /plugman reload 插件名稱   |
| 插件出現異常          | /plugman restart 插件名稱  |
| 更新了插件 .jar 檔案  | /plugman restart 插件名稱  |


# ============================================
# 6. 更新插件（不重啟伺服器）
# ============================================

## 完整更新流程

### 步驟 1：卸載舊版本

```
/plugman unload 插件名稱
```

### 步驟 2：備份並刪除舊檔案

```bash
# 備份
cp ~/Desktop/minecraft-server/plugins/插件名稱.jar ~/Desktop/minecraft-server/plugins/插件名稱.jar.bak

# 刪除舊版本
rm ~/Desktop/minecraft-server/plugins/插件名稱.jar
```

### 步驟 3：下載新版本

```bash
cd ~/Desktop/minecraft-server/plugins
wget -O 插件名稱.jar "新版本下載連結"
```

### 步驟 4：載入新版本

```
/plugman load 插件名稱
```

### 步驟 5：確認版本

```
/plugman info 插件名稱
```

## 範例：更新 GrimAC

```
/plugman unload GrimAC
```

```bash
rm ~/Desktop/minecraft-server/plugins/GrimAC.jar
cd ~/Desktop/minecraft-server/plugins
wget -O GrimAC.jar "新版本連結"
```

```
/plugman load GrimAC
/plugman info GrimAC
```

## 快速更新腳本範例

建立更新腳本 update-plugin.sh：

```bash
#!/bin/bash
# 使用方法: ./update-plugin.sh 插件名稱 下載連結

PLUGIN_NAME=$1
DOWNLOAD_URL=$2
PLUGIN_DIR=~/Desktop/minecraft-server/plugins

# 備份舊版本
cp "$PLUGIN_DIR/$PLUGIN_NAME.jar" "$PLUGIN_DIR/$PLUGIN_NAME.jar.bak"

# 下載新版本
wget -O "$PLUGIN_DIR/$PLUGIN_NAME.jar" "$DOWNLOAD_URL"

echo "插件已下載，請在遊戲內執行："
echo "/plugman unload $PLUGIN_NAME"
echo "/plugman load $PLUGIN_NAME"
```


# ============================================
# 7. 檢查插件更新
# ============================================

## 檢查更新指令

| 指令                      | 功能                           |
|--------------------------|-------------------------------|
| /plugman check <插件>     | 檢查單個插件是否有新版本        |
| /plugman check all        | 檢查所有插件是否有新版本        |

## 使用範例

檢查單個插件：
```
/plugman check WorldEdit
```

輸出範例：
```
WorldEdit 有新版本可用！
目前版本: 7.4.0
最新版本: 7.4.1
```

檢查所有插件：
```
/plugman check all
```

## ⚠️ 重要限制

此功能只能檢查在 **dev.bukkit.org**（CurseForge）上發布的插件。

### 可以檢查更新的插件 ✅

| 插件         | 發布平台        |
|-------------|----------------|
| WorldEdit   | dev.bukkit.org |
| WorldGuard  | dev.bukkit.org |
| Essentials  | dev.bukkit.org |
| CoreProtect | dev.bukkit.org |
| Skript      | dev.bukkit.org |

### 無法檢查更新的插件 ❌

| 插件        | 發布平台  | 手動檢查連結                                      |
|------------|----------|------------------------------------------------|
| GrimAC     | GitHub   | https://github.com/GrimAnticheat/Grim/releases |
| Geyser     | GitHub   | https://geysermc.org/download                  |
| Floodgate  | GitHub   | https://geysermc.org/download                  |
| LuckPerms  | GitHub   | https://luckperms.net/download                 |
| DiscordSRV | GitHub   | https://github.com/DiscordSRV/DiscordSRV/releases |
| PlugManX   | GitHub   | https://github.com/TheBlackEntity/PlugManX/releases |

## 替代方案：手動檢查 GitHub 插件

### 方法 1：訪問 GitHub Releases 頁面

直接訪問上表中的連結查看最新版本。

### 方法 2：使用終端機檢查（進階）

建立檢查腳本 check-github-plugin.sh：

```bash
#!/bin/bash
# 檢查 GitHub 插件最新版本
# 使用方法: ./check-github-plugin.sh 擁有者/倉庫名

REPO=$1
LATEST=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name"' | cut -d'"' -f4)
echo "最新版本: $LATEST"
```

使用範例：
```bash
./check-github-plugin.sh GrimAnticheat/Grim
./check-github-plugin.sh LuckPerms/LuckPerms
```

### 方法 3：安裝更新檢查插件

可以安裝專門的更新檢查插件：
- **Spark** - 效能監控 + 更新檢查
- **ServerUtils** - 伺服器工具 + 更新檢查

## 建議的更新檢查流程

```
1. /plugman check all          ← 檢查 Bukkit 插件
2. 手動查看 GitHub 插件頁面     ← 檢查 GitHub 插件
3. /plugman info <插件>         ← 確認目前版本
4. 決定是否更新
```


# ============================================
# 8. 查看插件資訊
# ============================================

## 列出所有插件

```
/plugman list
```

輸出範例：
```
Plugins (10): CoreProtect, Essentials, EssentialsSpawn, 
floodgate, Geyser-Spigot, GrimAC, LuckPerms, PlugManX, 
Skript, WorldEdit, WorldGuard
```

## 查看單個插件詳細資訊

```
/plugman info 插件名稱
```

輸出範例：
```
插件名稱: GrimAC
版本: 2.3.73
狀態: 已啟用
作者: DefineOutside
描述: Grim Anticheat
指令: /grim
```

## 查詢指令屬於哪個插件

```
/plugman lookup 指令名稱
```

範例：
```
/plugman lookup vanish
```

輸出：
```
指令 'vanish' 屬於插件: Essentials
```

## 查看插件的所有指令

```
/plugman usage 插件名稱
```


# ============================================
# 9. 常見問題
# ============================================

## Q1: 載入插件時顯示 "Plugin not found"

原因：插件檔案名稱與插件名稱不同

解決方法：
```
# 查看 plugins 資料夾中的檔案名稱
ls ~/Desktop/minecraft-server/plugins/

# 使用正確的檔案名稱（不含 .jar）
/plugman load 正確名稱
```

## Q2: 卸載插件後仍有殘留

原因：某些插件無法完全熱卸載

解決方法：重啟伺服器
```bash
sudo systemctl restart minecraft
```

## Q3: 載入後插件無法正常運作

原因：插件可能需要其他依賴插件

解決方法：
1. 檢查插件的依賴需求
2. 先載入依賴插件
3. 或重啟伺服器

## Q4: 更新後配置文件被覆蓋

原因：某些插件更新時會重置配置

解決方法：更新前先備份配置
```bash
cp -r ~/Desktop/minecraft-server/plugins/插件名稱/ ~/Desktop/minecraft-server/plugins/插件名稱.bak/
```

## Q5: 無法載入大型插件

原因：複雜插件可能需要完整重啟

解決方法：
- DiscordSRV、Geyser 等大型插件建議重啟載入
- 簡單插件（如 Vault）可以熱載入


# ============================================
# 10. 注意事項
# ============================================

## 可以安全熱載入的插件類型

✅ 簡單工具插件（Vault、EssentialsChat）
✅ 權限插件更新配置
✅ 小型功能插件

## 建議重啟載入的插件類型

⚠️ 跨平台插件（Geyser、Floodgate）
⚠️ 資料庫相關插件（CoreProtect、LuckPerms）
⚠️ 大型插件（DiscordSRV）
⚠️ 反作弊插件（GrimAC）
⚠️ 世界編輯插件（WorldEdit、WorldGuard）

## 最佳實踐

1. 重要更新前先備份
2. 在玩家較少時進行更新
3. 測試新版本是否正常
4. 保留舊版本備份檔案
5. 查看插件更新日誌確認相容性

## 權限節點

| 權限                    | 功能           |
|------------------------|----------------|
| plugman.*              | 所有權限        |
| plugman.admin          | 管理員權限      |
| plugman.load           | 載入插件        |
| plugman.unload         | 卸載插件        |
| plugman.reload         | 重載插件        |
| plugman.restart        | 重啟插件        |
| plugman.enable         | 啟用插件        |
| plugman.disable        | 停用插件        |
| plugman.check          | 檢查插件更新    |
| plugman.list           | 列出插件        |
| plugman.info           | 查看插件資訊    |
| plugman.lookup         | 查詢指令        |
| plugman.usage          | 查看用法        |
| plugman.dump           | 匯出插件列表    |


# ============================================
# 快速參考卡
# ============================================

## 載入新插件
```bash
# 1. 下載
wget -O ~/Desktop/minecraft-server/plugins/插件.jar "連結"
# 2. 載入
/plugman load 插件
```

## 卸載插件
```
/plugman unload 插件
```

## 更新插件
```
/plugman unload 插件
# 刪除舊版、下載新版
/plugman load 插件
```

## 重載配置
```
/plugman reload 插件
```

## 檢查更新
```
/plugman check 插件        # 檢查單個插件
/plugman check all         # 檢查所有插件
```

## 查看資訊
```
/plugman list
/plugman info 插件
```


# ============================================
# 結語
# ============================================

PlugManX 是一個非常實用的伺服器管理工具，
可以大幅減少因更新插件而需要重啟伺服器的次數。

但請記住：
- 簡單插件可以熱載入
- 複雜插件建議重啟
- 重要更新前務必備份

祝你伺服器管理順利！
