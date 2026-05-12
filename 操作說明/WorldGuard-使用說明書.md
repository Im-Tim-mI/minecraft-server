# WorldGuard 使用說明書

> 版本：7.0.15 | 適用於 Paper/Spigot 1.21.x

---

## 目錄

1. [基本概念](#基本概念)
2. [區域選擇](#區域選擇)
3. [區域管理](#區域管理)
4. [Flag 設定](#flag-設定)
5. [權限管理](#權限管理)
6. [常用保護範例](#常用保護範例)
7. [全域設定](#全域設定)
8. [故障排除](#故障排除)

---

## 基本概念

### 什麼是 WorldGuard？

WorldGuard 是 Minecraft 伺服器的區域保護插件，可以：
- 保護特定區域不被破壞
- 控制怪物生成
- 設定 PVP 規則
- 防止爆炸、火焰等破壞

### 前置需求

- WorldEdit（用於選擇區域範圍）

---

## 區域選擇

### 使用木斧選擇

```bash
# 取得選擇工具（木斧）
//wand
```

- **左鍵點擊**：設定點 1
- **右鍵點擊**：設定點 2

### 使用指令選擇

```bash
# 設定點 1（站在位置上執行）
//pos1

# 設定點 2
//pos2

# 直接指定座標
//pos1 100,64,200
//pos2 150,80,250

# 選擇當前所在的區塊
//chunk

# 擴展選擇範圍（向上下延伸到天空和基岩）
//expand vert
```

### 查看選擇範圍

```bash
# 查看目前選擇的範圍資訊
//size

# 查看選擇的座標
//sel
```

---

## 區域管理

### 建立區域

```bash
# 建立區域（需先用 WorldEdit 選擇範圍）
/rg define <區域名稱>
/rg create <區域名稱>

# 範例
/rg define spawn
/rg define my-house
```

### 刪除區域

```bash
/rg remove <區域名稱>
/rg delete <區域名稱>

# 範例
/rg remove spawn
```

### 重新定義區域範圍

```bash
# 先選擇新範圍，再執行
/rg redefine <區域名稱>
/rg update <區域名稱>
```

### 查看區域

```bash
# 列出所有區域
/rg list

# 列出特定世界的區域
/rg list -w world
/rg list -w world_nether
/rg list -w world_the_end

# 查看區域詳細資訊
/rg info <區域名稱>

# 查看當前位置的區域
/rg info
```

### 區域優先級

```bash
# 設定優先級（數字越高優先級越高）
/rg setpriority <區域名稱> <數字>

# 範例：spawn 區域優先級設為 10
/rg setpriority spawn 10
```

### 區域繼承

```bash
# 設定父區域（子區域會繼承父區域的設定）
/rg setparent <子區域> <父區域>

# 移除父區域
/rg setparent <子區域>
```

---

## Flag 設定

### 基本語法

```bash
/rg flag <區域名稱> <flag> <allow|deny|none>
```

### 建築相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `build` | 所有建築行為（包含破壞和放置） | `/rg flag spawn build deny` |
| `block-break` | 破壞方塊 | `/rg flag spawn block-break deny` |
| `block-place` | 放置方塊 | `/rg flag spawn block-place deny` |
| `interact` | 與方塊互動（按鈕、拉桿、門） | `/rg flag spawn interact deny` |
| `use` | 使用物品 | `/rg flag spawn use deny` |

### 怪物相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `mob-spawning` | 怪物生成 | `/rg flag spawn mob-spawning deny` |
| `mob-damage` | 怪物對玩家造成傷害 | `/rg flag spawn mob-damage deny` |
| `deny-spawn` | 禁止特定生物生成 | `/rg flag spawn deny-spawn creeper,zombie` |

### PVP 相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `pvp` | 玩家對戰 | `/rg flag spawn pvp deny` |
| `invincible` | 玩家無敵 | `/rg flag spawn invincible allow` |

### 爆炸相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `creeper-explosion` | 苦力怕爆炸破壞 | `/rg flag spawn creeper-explosion deny` |
| `tnt` | TNT 爆炸破壞 | `/rg flag spawn tnt deny` |
| `other-explosion` | 其他爆炸（末影水晶等） | `/rg flag spawn other-explosion deny` |

### 環境相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `fire-spread` | 火焰蔓延 | `/rg flag spawn fire-spread deny` |
| `lava-fire` | 岩漿引發火災 | `/rg flag spawn lava-fire deny` |
| `lava-flow` | 岩漿流動 | `/rg flag spawn lava-flow deny` |
| `water-flow` | 水流動 | `/rg flag spawn water-flow deny` |
| `snow-fall` | 雪累積 | `/rg flag spawn snow-fall deny` |
| `snow-melt` | 雪融化 | `/rg flag spawn snow-melt deny` |
| `ice-form` | 冰形成 | `/rg flag spawn ice-form deny` |
| `ice-melt` | 冰融化 | `/rg flag spawn ice-melt deny` |
| `leaf-decay` | 樹葉消失 | `/rg flag spawn leaf-decay deny` |
| `grass-spread` | 草蔓延 | `/rg flag spawn grass-spread deny` |

### 存取相關 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `entry` | 進入區域 | `/rg flag spawn entry deny` |
| `exit` | 離開區域 | `/rg flag spawn exit deny` |
| `chest-access` | 開啟箱子 | `/rg flag spawn chest-access deny` |
| `vehicle-place` | 放置載具（船、礦車） | `/rg flag spawn vehicle-place deny` |
| `vehicle-destroy` | 破壞載具 | `/rg flag spawn vehicle-destroy deny` |

### 玩家狀態 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `heal-amount` | 治療量（每秒） | `/rg flag spawn heal-amount 2` |
| `heal-delay` | 治療間隔（秒） | `/rg flag spawn heal-delay 1` |
| `feed-amount` | 補充飢餓值 | `/rg flag spawn feed-amount 2` |
| `feed-delay` | 補充間隔（秒） | `/rg flag spawn feed-delay 1` |

### 訊息 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `greeting` | 進入區域時顯示訊息 | `/rg flag spawn greeting 歡迎來到出生點！` |
| `farewell` | 離開區域時顯示訊息 | `/rg flag spawn farewell 再見！` |
| `greeting-title` | 進入時顯示標題 | `/rg flag spawn greeting-title 出生點` |
| `farewell-title` | 離開時顯示標題 | `/rg flag spawn farewell-title 離開出生點` |
| `deny-message` | 被拒絕時顯示訊息 | `/rg flag spawn deny-message 你沒有權限！` |

### 其他 Flags

| Flag | 說明 | 範例 |
|------|------|------|
| `passthrough` | 是否檢查此區域的權限 | `/rg flag spawn passthrough deny` |
| `enderpearl` | 使用乾達爾珍珠傳送 | `/rg flag spawn enderpearl deny` |
| `chorus-fruit-teleport` | 歌萊果傳送 | `/rg flag spawn chorus-fruit-teleport deny` |
| `item-pickup` | 撿起物品 | `/rg flag spawn item-pickup deny` |
| `item-drop` | 丟棄物品 | `/rg flag spawn item-drop deny` |
| `exp-drops` | 經驗球掉落 | `/rg flag spawn exp-drops deny` |
| `send-chat` | 發送聊天訊息 | `/rg flag spawn send-chat deny` |
| `receive-chat` | 接收聊天訊息 | `/rg flag spawn receive-chat deny` |

### 清除 Flag

```bash
# 將 flag 設為 none（使用預設值）
/rg flag <區域名稱> <flag> none

# 或直接不加值
/rg flag <區域名稱> <flag>
```

---

## 權限管理

### 區域擁有者（Owner）

擁有者擁有區域的完全控制權，不受 flag 限制。

```bash
# 添加擁有者
/rg addowner <區域名稱> <玩家名稱>

# 添加多個擁有者
/rg addowner <區域名稱> 玩家1 玩家2 玩家3

# 移除擁有者
/rg removeowner <區域名稱> <玩家名稱>
```

### 區域成員（Member）

成員擁有基本的建築權限，受部分 flag 限制。

```bash
# 添加成員
/rg addmember <區域名稱> <玩家名稱>

# 移除成員
/rg removemember <區域名稱> <玩家名稱>
```

### 權限群組

```bash
# 添加權限群組作為擁有者
/rg addowner <區域名稱> g:群組名稱

# 範例：添加 vip 群組作為成員
/rg addmember shop g:vip
```

---

## 常用保護範例

### 出生點保護

```bash
# 1. 選擇範圍
//pos1 -100,0,-100
//pos2 100,255,100
//expand vert

# 2. 建立區域
/rg define spawn

# 3. 設定保護
/rg flag spawn build deny
/rg flag spawn mob-spawning deny
/rg flag spawn mob-damage deny
/rg flag spawn pvp deny
/rg flag spawn creeper-explosion deny
/rg flag spawn tnt deny
/rg flag spawn fire-spread deny
/rg flag spawn greeting &a歡迎來到出生點！
/rg flag spawn invincible allow
/rg flag spawn heal-amount 1
/rg flag spawn heal-delay 1

# 4. 設定擁有者
/rg addowner spawn .Tim901038
```

### 禁止 PVP 區域

```bash
/rg define no-pvp
/rg flag no-pvp pvp deny
/rg flag no-pvp greeting &c此區域禁止 PVP
```

### 競技場（只允許 PVP）

```bash
/rg define arena
/rg flag arena pvp allow
/rg flag arena build deny
/rg flag arena mob-spawning deny
/rg flag arena greeting &4進入競技場！準備戰鬥！
```

### 商店區域

```bash
/rg define shop
/rg flag shop build deny
/rg flag shop chest-access allow
/rg flag shop interact allow
/rg flag shop use allow
/rg flag shop mob-spawning deny
/rg flag shop pvp deny
```

### 農場保護（允許採收）

```bash
/rg define farm
/rg flag farm block-break allow
/rg flag farm block-place deny
/rg flag farm mob-spawning deny
```

### VIP 專屬區域

```bash
/rg define vip-zone
/rg flag vip-zone entry -g nonmembers deny
/rg flag vip-zone deny-message &c只有 VIP 才能進入此區域！
/rg addmember vip-zone g:vip
```

---

## 全域設定

### 全域區域

每個世界都有一個名為 `__global__` 的全域區域。

```bash
# 設定全域 flag
/rg flag __global__ <flag> <值>

# 範例：全服禁止苦力怕爆炸
/rg flag __global__ creeper-explosion deny

# 範例：全服禁止 TNT
/rg flag __global__ tnt deny

# 範例：全服禁止 PVP
/rg flag __global__ pvp deny
```

### 配置檔案

配置檔案位置：`plugins/WorldGuard/config.yml`

常用設定：
```yaml
# 禁止某些物品使用
blacklist:
  enabled: true
  
# 建築權限
build-permission-nodes:
  enable: true
```

---

## 故障排除

### 區域不生效？

1. **檢查區域範圍**
   ```bash
   /rg info <區域名稱>
   ```

2. **檢查優先級**
   - 多個區域重疊時，高優先級的設定會覆蓋低優先級
   ```bash
   /rg setpriority <區域名稱> 10
   ```

3. **檢查玩家是否為擁有者/成員**
   - 擁有者和成員不受建築限制

4. **檢查 passthrough flag**
   ```bash
   /rg flag <區域名稱> passthrough deny
   ```

### 常見錯誤

| 問題 | 解決方案 |
|------|----------|
| 區域沒有保護效果 | 檢查是否設定了 `build deny` |
| 怪物還是會生成 | 確認 `mob-spawning deny` 已設定 |
| 成員無法建築 | 檢查 `build` flag 是否設為 `deny` |
| PVP 還是開啟 | 確認 `pvp deny` 已設定 |

### 重新載入設定

```bash
/rg reload
```

---

## 快速參考

### 建立完整保護區域

```bash
# 1. 選擇範圍
//pos1
//pos2

# 2. 建立並保護
/rg define <名稱>
/rg flag <名稱> build deny
/rg flag <名稱> mob-spawning deny
/rg flag <名稱> mob-damage deny
/rg flag <名稱> pvp deny
/rg flag <名稱> creeper-explosion deny
/rg flag <名稱> tnt deny
/rg addowner <名稱> <玩家>
```

### 常用指令總覽

| 指令 | 功能 |
|------|------|
| `/rg define <名稱>` | 建立區域 |
| `/rg remove <名稱>` | 刪除區域 |
| `/rg list` | 列出所有區域 |
| `/rg info <名稱>` | 查看區域資訊 |
| `/rg flag <名稱> <flag> <值>` | 設定 flag |
| `/rg addowner <名稱> <玩家>` | 添加擁有者 |
| `/rg addmember <名稱> <玩家>` | 添加成員 |
| `/rg removeowner <名稱> <玩家>` | 移除擁有者 |
| `/rg removemember <名稱> <玩家>` | 移除成員 |
| `/rg setpriority <名稱> <數字>` | 設定優先級 |
| `/rg reload` | 重新載入設定 |

---

## 相關資源

- [WorldGuard 官方文檔](https://worldguard.enginehub.org/en/latest/)
- [WorldGuard Flag 列表](https://worldguard.enginehub.org/en/latest/regions/flags/)
- [WorldEdit 使用說明](https://worldedit.enginehub.org/en/latest/)

---

*說明書製作：2026-03-27 | Minecraft 伺服器管理*
