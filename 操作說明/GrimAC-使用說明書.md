# GrimAC 反作弊插件使用說明書

## 目錄

1. [什麼是 GrimAC？](#什麼是-grimac)
2. [安裝與設定](#安裝與設定)
3. [指令大全](#指令大全)
4. [權限節點](#權限節點)
5. [檢測類型說明](#檢測類型說明)
6. [配置文件詳解](#配置文件詳解)
7. [處罰系統設定](#處罰系統設定)
8. [效能優化建議](#效能優化建議)
9. [常見問題](#常見問題)
10. [最佳實踐](#最佳實踐)

---

## 什麼是 GrimAC？

**GrimAC**（Grim AntiCheat）是一款開源的 Minecraft 反作弊插件，採用**預測式檢測**技術。

### 特點

| 特點 | 說明 |
|------|------|
| 預測式檢測 | 模擬玩家移動，比對實際與預期差異 |
| 低誤判率 | 比傳統反作弊更精準 |
| 高效能 | 異步處理，不影響 TPS |
| 開源免費 | GitHub 上完全開源 |
| 持續更新 | 活躍的開發社群 |

### 可檢測的作弊類型

- **移動類**：飛行、加速、穿牆、蜘蛛爬牆、Jesus（水上行走）
- **戰鬥類**：Killaura、Reach（攻擊距離）、Hitbox（碰撞箱）、自動點擊
- **封包類**：Timer（加速封包）、BadPackets（惡意封包）
- **其他**：NoSlow（取消減速）、Scaffold（自動搭路）

---

## 安裝與設定

### 安裝步驟

```bash
# 1. 下載 GrimAC
cd ~/minecraft-server/plugins
wget -O GrimAC.jar https://github.com/GrimAnticheat/Grim/releases/latest/download/Grim.jar

# 2. 重啟伺服器
sudo systemctl restart minecraft
```

### 檔案結構

```
plugins/
└── GrimAC/
    ├── config.yml           # 主配置文件
    ├── messages.yml          # 訊息文件
    ├── punishments.yml       # 處罰設定
    └── discord.yml           # Discord 整合（可選）
```

### 依賴插件

| 插件 | 必要性 | 說明 |
|------|--------|------|
| ProtocolLib | 可選 | 提供更好的封包處理 |
| PacketEvents | 內建 | GrimAC 自帶 |
| Floodgate | 可選 | 基岩版玩家支援 |

---

## 指令大全

### 基本指令

| 指令 | 說明 | 權限 |
|------|------|------|
| `/grim` | 顯示 GrimAC 資訊 | 無 |
| `/grim alerts` | 開關作弊警報 | `grim.alerts` |
| `/grim alerts [玩家]` | 查看特定玩家的警報 | `grim.alerts` |
| `/grim profile <玩家>` | 查看玩家的作弊檔案 | `grim.profile` |
| `/grim verbose` | 開關詳細模式（顯示所有檢測） | `grim.verbose` |
| `/grim perf` | 查看效能統計 | `grim.performance` |
| `/grim reload` | 重載配置文件 | `grim.reload` |

### 除錯指令

| 指令 | 說明 | 權限 |
|------|------|------|
| `/grim debug <玩家>` | 開啟對特定玩家的除錯模式 | `grim.debug` |
| `/grim log <玩家>` | 查看玩家的違規日誌 | `grim.log` |
| `/grim spectate <玩家>` | 旁觀模式監視玩家 | `grim.spectate` |

### 管理指令

| 指令 | 說明 | 權限 |
|------|------|------|
| `/grim exempt <玩家> <檢測>` | 豁免玩家某項檢測 | `grim.exempt` |
| `/grim flagreset <玩家>` | 重置玩家的違規次數 | `grim.flagreset` |

---

## 權限節點

### 基本權限

| 權限 | 說明 | 預設 |
|------|------|------|
| `grim.alerts` | 接收作弊警報 | OP |
| `grim.alerts.verbose` | 接收詳細警報 | OP |
| `grim.profile` | 查看玩家檔案 | OP |
| `grim.brand` | 查看玩家客戶端品牌 | OP |

### 管理權限

| 權限 | 說明 | 預設 |
|------|------|------|
| `grim.reload` | 重載配置 | OP |
| `grim.performance` | 查看效能 | OP |
| `grim.debug` | 除錯模式 | OP |
| `grim.exempt` | 豁免玩家 | OP |
| `grim.flagreset` | 重置違規 | OP |

### 繞過權限

| 權限 | 說明 |
|------|------|
| `grim.exempt.*` | 豁免所有檢測 |
| `grim.exempt.simulation` | 豁免移動模擬檢測 |
| `grim.exempt.reach` | 豁免攻擊距離檢測 |
| `grim.exempt.timer` | 豁免 Timer 檢測 |
| `grim.nosetback` | 不會被拉回 |

---

## 檢測類型說明

### 移動類檢測

#### Simulation（移動模擬）
檢測玩家移動是否符合物理規則。

| 子檢測 | 說明 |
|--------|------|
| `Simulation` | 預測玩家下一個位置，比對實際位置 |
| `Gravity` | 檢測是否遵守重力 |
| `Friction` | 檢測是否遵守摩擦力 |

**常見觸發原因**：
- 飛行作弊
- 加速作弊
- 高延遲玩家（誤判）

---

#### GroundSpoof（地面欺騙）
檢測玩家是否假裝在地面上。

---

#### Timer（計時器）
檢測玩家是否發送過多或過少的移動封包。

| 類型 | 說明 |
|------|------|
| Timer A | 封包發送過快（加速） |
| Timer B | 封包發送過慢（減速） |

---

#### Entity（實體相關）
檢測與實體互動時的異常。

| 子檢測 | 說明 |
|--------|------|
| `EntityFlight` | 騎乘實體時飛行 |
| `EntitySpeed` | 騎乘實體時加速 |

---

### 戰鬥類檢測

#### Reach（攻擊距離）
檢測玩家是否攻擊超出正常距離的目標。

| 版本 | 正常距離 |
|------|----------|
| 1.8 | 3.0 格 |
| 1.9+ | 3.0 格 |
| 創造模式 | 5.0 格 |

---

#### Hitbox（碰撞箱）
檢測玩家是否攻擊目標碰撞箱外的位置。

---

#### Aim（瞄準）
檢測異常的瞄準行為。

| 子檢測 | 說明 |
|--------|------|
| `AimA` | 瞄準角度異常 |
| `AimB` | 瞄準速度異常（Snap） |
| `AimC` | 瞄準模式異常 |

---

#### AutoClicker（自動點擊）
檢測異常的點擊速度和模式。

| 指標 | 正常範圍 |
|------|----------|
| CPS（每秒點擊） | 6-14 |
| 點擊間隔一致性 | 有變化 |

---

### 封包類檢測

#### BadPackets（惡意封包）
檢測各種異常封包。

| 子檢測 | 說明 |
|--------|------|
| `BadPacketsA` | 地面狀態異常 |
| `BadPacketsB` | 座標異常 |
| `BadPacketsC` | Pitch 角度超出範圍 |
| `BadPacketsD` | 在載具中移動異常 |
| `BadPacketsE` | 攻擊自己 |
| `BadPacketsF` | 無效的物品使用 |
| `BadPacketsG` | 快速切換物品欄 |

---

#### Post（延遲封包）
檢測玩家是否延遲發送封包來獲得優勢。

---

### 其他檢測

#### NoSlow（取消減速）
檢測玩家是否在應該減速時保持正常速度。

| 情況 | 正常減速 |
|------|----------|
| 使用物品（進食、拉弓） | 80% 減速 |
| 潛行 | 70% 減速 |
| 在蜘蛛網中 | 極大減速 |
| 在靈魂沙上 | 減速 |

---

#### Scaffold（自動搭路）
檢測異常的方塊放置行為。

---

#### Baritone（自動尋路）
檢測是否使用 Baritone 之類的自動尋路工具。

---

## 配置文件詳解

### config.yml 主要設定

```yaml
# 是否啟用 GrimAC
enabled: true

# 最大玩家延遲（超過此值的玩家不會被檢測）
max-player-ping: 1000

# 移動檢測靈敏度
# 值越低越嚴格，但誤判可能增加
simulation-threshold: 0.001

# 是否檢測基岩版玩家（透過 Geyser/Floodgate）
# 建議設為 false，因為基岩版玩家行為不同
check-geyser-players: false

# 是否在控制台顯示警報
console-alerts: true

# 異步執行（推薦開啟）
async-check: true

# Setback（拉回）設定
setback:
  # 是否啟用拉回
  enabled: true
  # 拉回的延遲（毫秒）
  delay: 0
```

### messages.yml 訊息設定

```yaml
# 警報格式
alerts-format: "&8[&cGrim&8] &7{player} &7failed &c{check} &7({details})"

# 詳細模式格式
verbose-format: "&8[&cGrim&8] &7{player} &7flagged &c{check} &7VL: {vl}"

# 前綴
prefix: "&8[&cGrimAC&8]&r "
```

---

## 處罰系統設定

### punishments.yml 結構

```yaml
# 處罰群組
Punishments:
  # 群組名稱
  Simulation:
    # 要包含的檢測
    checks:
      - "Simulation"
      - "GroundSpoof"
    # 處罰動作
    commands:
      # 違規次數 -> 執行的指令
      20: "grim.alert %player% 可能在作弊"
      50: "kick %player% 移動異常"
      100: "ban %player% 1h 移動作弊"
    # 違規次數衰減間隔（秒）
    decay: 0.05

  Combat:
    checks:
      - "Reach"
      - "Hitbox"
    commands:
      10: "grim.alert %player% 戰鬥異常"
      30: "kick %player% 戰鬥作弊"
      50: "ban %player% 7d 使用作弊客戶端"
    decay: 0.02
```

### 處罰動作說明

| 佔位符 | 說明 |
|--------|------|
| `%player%` | 玩家名稱 |
| `%check%` | 檢測名稱 |
| `%vl%` | 違規等級 |
| `%ping%` | 玩家延遲 |
| `%tps%` | 伺服器 TPS |

### 常用處罰指令範例

```yaml
commands:
  # 只警告管理員
  20: "grim.alert %player% 可能使用 %check%"
  
  # 踢出玩家
  50: "kick %player% 檢測到異常行為"
  
  # 臨時封禁
  100: "tempban %player% 1d 作弊行為"
  
  # 永久封禁
  200: "ban %player% 使用作弊客戶端"
```

---

## 效能優化建議

### 針對你的伺服器（TPS 較低）

由於你的伺服器 TPS 在 12-13 左右，建議以下優化：

```yaml
# config.yml

# 提高延遲容忍度
max-player-ping: 1500

# 降低檢測靈敏度（減少誤判）
simulation-threshold: 0.01

# 啟用異步處理
async-check: true
```

### punishments.yml 優化

建議清空或簡化以下檢測（容易誤判）：

```yaml
Simulation:
  checks: []  # 清空，因為低 TPS 容易誤判

Knockback:
  checks: []  # 清空

Post:
  checks: []  # 清空

Misc:
  checks:
    - "!Vehicle"      # 排除載具檢測
    - "!NoSlow"       # 排除減速檢測
    - "!Sprint"       # 排除衝刺檢測
    - "!Elytra"       # 排除鞘翅檢測
```

### 保留的重要檢測

```yaml
Combat:
  checks:
    - "Reach"
    - "Hitbox"
  commands:
    30: "grim.alert %player% 戰鬥異常"
    60: "kick %player% 戰鬥作弊"
  decay: 0.01

BadPackets:
  checks:
    - "BadPacketsA"
    - "BadPacketsB"
    - "BadPacketsC"
    - "BadPacketsE"
  commands:
    10: "kick %player% 惡意封包"
  decay: 0.05

Autoclicker:
  checks:
    - "Autoclicker"
  commands:
    20: "grim.alert %player% CPS 異常"
    40: "kick %player% 自動點擊"
  decay: 0.03
```

---

## 常見問題

### Q: 玩家被誤判怎麼辦？

**解決方案**：

1. 檢查玩家延遲：
   ```
   /grim profile <玩家>
   ```

2. 如果是高延遲玩家，暫時豁免：
   ```
   /grim exempt <玩家> simulation
   ```

3. 調整 `max-player-ping` 設定。

---

### Q: 基岩版玩家一直被誤判？

**解決方案**：

在 `config.yml` 中設定：
```yaml
check-geyser-players: false
```

或給予基岩版玩家豁免權限：
```
/lp group default permission set grim.exempt.* true
```
（針對以 `.` 開頭的玩家）

---

### Q: 礦車/船經常觸發檢測？

**解決方案**：

在 `punishments.yml` 中排除載具檢測：
```yaml
Misc:
  checks:
    - "!Vehicle"
    - "!EntityControl"
```

---

### Q: 低 TPS 時誤判很多？

**解決方案**：

1. 提高閾值：
   ```yaml
   simulation-threshold: 0.01
   ```

2. 清空敏感檢測：
   ```yaml
   Simulation:
     checks: []
   Knockback:
     checks: []
   ```

3. 先解決 TPS 問題再啟用完整檢測。

---

### Q: 如何查看玩家的作弊記錄？

```
/grim log <玩家>
/grim profile <玩家>
```

---

### Q: 如何監視可疑玩家？

```
/grim spectate <玩家>
```

這會讓你以旁觀模式跟隨該玩家。

---

### Q: 如何重置玩家的違規次數？

```
/grim flagreset <玩家>
```

---

## 最佳實踐

### 1. 循序漸進

```
第一週：只開啟警報，不處罰
    ↓
第二週：對明顯作弊進行踢出
    ↓
第三週：開啟完整處罰系統
```

### 2. 建立合理的處罰階梯

```yaml
commands:
  # 第一階段：內部警報
  20: "grim.alert %player% 可疑行為 (%check%)"
  
  # 第二階段：警告玩家
  40: "tellraw %player% {\"text\":\"[警告] 檢測到異常行為\",\"color\":\"red\"}"
  
  # 第三階段：踢出
  60: "kick %player% 檢測到異常行為，請檢查網路連線"
  
  # 第四階段：臨時封禁
  100: "tempban %player% 1h 異常行為"
  
  # 第五階段：長期封禁
  200: "ban %player% 使用作弊客戶端"
```

### 3. 記錄重要事件

```yaml
# 在處罰時記錄
commands:
  100: "ban %player% 作弊"
  100: "broadcast &c%player% 因作弊被封禁"
```

### 4. 定期檢查日誌

```bash
# 查看 GrimAC 相關日誌
grep -i "grim" ~/minecraft-server/logs/latest.log
```

### 5. 針對特定玩家群組

使用 LuckPerms 設定不同群組的豁免：

```bash
# VIP 玩家較寬鬆
/lp group vip permission set grim.exempt.simulation true

# 管理員完全豁免
/lp group admin permission set grim.exempt.* true
```

---

## 快速參考卡

```
┌─────────────────────────────────────────────────────┐
│              GrimAC 快速參考                         │
├─────────────────────────────────────────────────────┤
│  常用指令：                                          │
│  /grim alerts          - 開關警報                    │
│  /grim profile <玩家>  - 查看玩家檔案                │
│  /grim verbose         - 詳細模式                    │
│  /grim reload          - 重載配置                    │
│  /grim spectate <玩家> - 監視玩家                    │
│                                                      │
│  配置文件：                                          │
│  plugins/GrimAC/config.yml       - 主設定            │
│  plugins/GrimAC/punishments.yml  - 處罰設定          │
│  plugins/GrimAC/messages.yml     - 訊息設定          │
│                                                      │
│  檢測類型：                                          │
│  Simulation = 移動    Combat = 戰鬥                  │
│  BadPackets = 封包    Timer = 計時器                 │
│  Autoclicker = 自動點擊                              │
│                                                      │
│  誤判處理：                                          │
│  /grim exempt <玩家> <檢測>  - 豁免特定檢測          │
│  /grim flagreset <玩家>      - 重置違規次數          │
└─────────────────────────────────────────────────────┘
```

---

*文件版本：1.0*
*適用於 GrimAC 2.3.73*
*最後更新：2026-03-25*
