# 🗺️ 創世神服務器配置文件

> **禁止商業用途** — 授權條款：[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

---

## 📖 關於此 Repo

這是 **清交 · 交清 虛擬交流服務器**（tim945 服務器）的公開配置文件。

配置文件中包含服主自行撰寫的腳本，公開此 Repo 主要希望：

- 大家能一起思考如何**優化**現有配置
- 開放社群**貢獻插件**，歡迎以下形式：
  - ☕ Java 插件
  - 📜 Skript 腳本（`.sk` 插件）# 請優先考慮

---

## 🔗 連結

| | |
|---|---|
| 🎮 創世神遊戲服務器地址 | `mc.tim945.com` |
| 💬 Discord | [加入交流](https://discord.gg/CkCPd2CAy4) |

---

## 🖥️ 服務器環境

| | |
|---|---|
| 框架 | [PaperMC](https://fill-data.papermc.io/v1/objects/5ffef465eeeb5f2a3c23a24419d97c51afd7dbb4923ff42df9a3f58bba1ccfba/paper-1.21.11-132.jar) |
| 版本 | 1.21.1 |

---

## 🚀 啟動方式

下載配置文件後，將 [PaperMC 1.21.1](https://fill-data.papermc.io/v1/objects/5ffef465eeeb5f2a3c23a24419d97c51afd7dbb4923ff42df9a3f58bba1ccfba/paper-1.21.11-132.jar) 的 `.jar` 更名為 `server.jar` 放入根目錄，然後執行：

```bash
cd ~/minecraft-server
java -Xmx4G -Xms2G -jar server.jar nogui
```

| 參數 | 說明 |
|------|------|
| `-Xmx4G` | 最大記憶體 4GB |
| `-Xms2G` | 初始記憶體 2GB |
| `nogui` | 不開啟圖形介面（伺服器環境用）|

> 記憶體大小可依照你的主機規格自行調整。

---

## 🧩 插件清單

下載後放入`plugins`資料夾中

| 插件 | 版本 | 下載 |
|------|------|------|
| CoreProtect CE | 23.1 | [下載](https://github.com/PlayPro/CoreProtect) |
| DiscordSRV | 1.30.5 | [下載](https://www.spigotmc.org/resources/discordsrv.18494/) |
| EssentialsX | 2.21.2 | [下載](https://essentialsx.net) |
| EssentialsXSpawn | 2.21.2 | [下載](https://essentialsx.net) |
| Geyser | 最新 | [下載](https://geysermc.org) |
| Floodgate | 最新 | [下載](https://geysermc.org/download#floodgate) |
| InteractiveChat | 2026.1.0.0 | [下載](https://www.spigotmc.org/resources/interactivechat.75870/) |
| InteractiveChat DiscordSRV Addon | 2026.1.0.0 | [下載](https://www.spigotmc.org/resources/interactivechat-discordsrv-addon.82855/) |
| LuckPerms | 5.5.44 | [下載](https://luckperms.net) |
| PlaceholderAPI | 2.12.2 | [下載](https://www.spigotmc.org/resources/placeholderapi.6245/) |
| PlugManX | 3.0.4 | [下載](https://www.spigotmc.org/resources/plugmanx.88135/) |
| ProtocolLib | 最新 | [下載](https://www.spigotmc.org/resources/protocollib.1997/) |
| Skript | 2.15.2 | [下載](https://github.com/SkriptLang/Skript) |
| SkBee | 最新 | [下載](https://github.com/ShaneBeee/SkBee) |
| GrimAC | 最新 | [下載](https://github.com/GrimAnticheat/Grim) |
| Vault | 最新 | [下載](https://www.spigotmc.org/resources/vault.34315/) |
| ViaVersion | 5.9.1 | [下載](https://viaversion.com) |
| ViaBackwards | 5.9.1 | [下載](https://viaversion.com) |
| Multiverse-Core | 5.6.2 | [下載](https://dev.bukkit.org/projects/multiverse-core) |
| Multiverse-Portals | 5.2.2 | [下載](https://dev.bukkit.org/projects/multiverse-portals) |
| spark | 1.10.172 | [下載](https://spark.lucko.me) |
| WorldEdit | 7.4.3 | [下載](https://enginehub.org/worldedit) |
| WorldGuard | 7.0.16 | [下載](https://enginehub.org/worldguard) |

---

## ✍️ 撰寫 Skript 腳本（`.sk` 插件）

將腳本檔案放入以下路徑：

​```plugins/Skript/scripts/```

放入後在遊戲或控制台執行以下指令載入：

​```/skript reload all          # 重載全部腳本​```

​```/skript reload <腳本檔名>   # 只重載單一腳本​```

---

## ⚖️ 授權聲明

本配置文件採用 **CC BY-NC-SA 4.0** 授權：

- ✅ 可自由下載、分享、修改
- ✅ 修改後必須以相同授權公開
- ❌ **禁止商業用途**
- ❌ 修改後不得更換授權條款

Copyright (c) 2026 tim945
