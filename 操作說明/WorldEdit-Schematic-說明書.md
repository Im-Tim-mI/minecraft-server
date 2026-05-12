# WorldEdit Schematic 工具操作說明書

## 目錄

1. [什麼是 Schematic？](#什麼是-schematic)
2. [基本指令速查表](#基本指令速查表)
3. [保存建築](#保存建築)
4. [載入建築](#載入建築)
5. [貼上選項](#貼上選項)
6. [管理 Schematic 檔案](#管理-schematic-檔案)
7. [進階用法](#進階用法)
8. [效能優化建議](#效能優化建議)
9. [常見問題](#常見問題)

---

## 什麼是 Schematic？

Schematic 是 WorldEdit 用來保存和載入建築結構的檔案格式。你可以把任何建築保存成 `.schem` 檔案，然後在任何時候、任何地方貼上它。

### 檔案位置

```
~/minecraft-server/plugins/WorldEdit/schematics/
```

### 支援格式

| 格式 | 副檔名 | 說明 |
|------|--------|------|
| Sponge | `.schem` | 新格式，推薦使用 |
| MCEdit | `.schematic` | 舊格式，相容性用 |

---

## 基本指令速查表

| 指令 | 功能 |
|------|------|
| `//wand` | 取得選區木斧 |
| `//copy` | 複製選區到剪貼板 |
| `//cut` | 剪下選區到剪貼板 |
| `//paste` | 貼上剪貼板內容 |
| `//schem save <名稱>` | 保存剪貼板到檔案 |
| `//schem load <名稱>` | 從檔案載入到剪貼板 |
| `//schem list` | 列出所有已保存的檔案 |
| `//schem delete <名稱>` | 刪除檔案 |
| `//undo` | 復原上一個操作 |
| `//redo` | 重做上一個操作 |

---

## 保存建築

### 步驟一：選取區域

#### 方法 A：使用木斧

```
//wand
```

1. 取得木斧後，**左鍵**點擊第一個角落 → 設定 pos1
2. **右鍵**點擊對角的角落 → 設定 pos2

#### 方法 B：使用指令設定座標

```
//pos1
//pos2
```

站在想要的位置執行指令即可設定。

#### 方法 C：選取整個區塊

```
//chunk
```

自動選取你所在的 16x16 區塊（從基岩到天空）。

### 步驟二：調整選區（可選）

```bash
# 垂直擴展到整個高度
//expand vert

# 向各方向擴展
//expand 10 up        # 向上擴展 10 格
//expand 10 down      # 向下擴展 10 格
//expand 10 north     # 向北擴展 10 格
//expand 10 10 h      # 水平四向各擴展 10 格

# 查看選區大小
//size

# 查看選區資訊
//sel
```

### 步驟三：複製選區

```
//copy
```

> ⚠️ 複製時會記錄你的位置作為相對原點。貼上時會以這個位置為基準。

### 步驟四：保存到檔案

```bash
# 基本保存（預設 .schem 格式）
//schem save 我的房子

# 指定格式保存
//schem save sponge 我的房子      # 新格式（推薦）
//schem save mcedit 我的房子      # 舊格式
```

### 完整範例

```bash
//wand                    # 取得木斧
# （用木斧左鍵右鍵選取建築）
//expand vert             # 擴展到完整高度
//copy                    # 複製
//schem save spawn_backup # 保存
```

---

## 載入建築

### 步驟一：載入檔案到剪貼板

```bash
//schem load 我的房子

# 或完整檔名
//schem load 我的房子.schem
```

### 步驟二：貼上

```bash
# 貼到你目前的位置
//paste

# 貼到建築保存時的原始位置
//paste -o
```

---

## 貼上選項

| 指令 | 說明 |
|------|------|
| `//paste` | 貼到你站的位置 |
| `//paste -o` | 貼到原始保存位置（推薦還原用） |
| `//paste -a` | 忽略空氣方塊（不覆蓋現有方塊） |
| `//paste -s` | 只選取範圍，不實際貼上（預覽用） |
| `//paste -n` | 不貼上，只選取並顯示受影響區域 |
| `//paste -o -a` | 原始位置 + 忽略空氣（組合使用） |

### 旋轉和翻轉

在貼上之前，可以旋轉或翻轉剪貼板內容：

```bash
# 旋轉（以你為中心）
//rotate 90       # 順時針旋轉 90 度
//rotate 180      # 旋轉 180 度
//rotate -90      # 逆時針旋轉 90 度

# 翻轉
//flip up         # 上下翻轉
//flip north      # 南北翻轉
//flip west       # 東西翻轉
```

---

## 管理 Schematic 檔案

### 列出所有檔案

```bash
//schem list

# 分頁顯示
//schem list 1
//schem list 2
```

### 刪除檔案

```bash
//schem delete 舊備份
```

### 查看檔案格式

```bash
//schem list -p sponge    # 只顯示 .schem 格式
//schem list -p mcedit    # 只顯示 .schematic 格式
```

### 檔案資料夾結構

可以使用子資料夾整理：

```bash
# 保存到子資料夾
//schem save 備份/房子_v1

# 從子資料夾載入
//schem load 備份/房子_v1
```

---

## 進階用法

### 剪貼板操作

```bash
# 複製（保留原建築）
//copy

# 剪下（移除原建築）
//cut

# 清空剪貼板
//clearclipboard
```

### 使用生物群系

```bash
# 複製時包含生物群系
//copy -b

# 貼上時包含生物群系
//paste -b
```

### 使用實體

```bash
# 複製時包含實體（生物、物品展示框等）
//copy -e

# 貼上時包含實體
//paste -e
```

### 組合選項

```bash
# 複製時包含生物群系和實體
//copy -b -e

# 貼到原始位置，忽略空氣，包含實體
//paste -o -a -e
```

---

## 效能優化建議

大型建築操作可能導致伺服器卡頓。以下是優化建議：

### 執行大型操作前

```bash
# 關閉副作用
//perf neighbors off    # 關閉相鄰方塊更新
//perf lighting off     # 關閉光照計算

# 執行操作
//paste -o

# 重新開啟
//perf neighbors on
//perf lighting on
```

### 分批操作

如果建築太大，考慮分成多個部分：

```bash
# 不要一次選取整棟大樓
# 改為分層或分區保存

//schem save 大樓_1樓
//schem save 大樓_2樓
//schem save 大樓_3樓
```

### 避免 //regen 大範圍

`//regen` 指令非常耗效能，建議：

1. 選取較小範圍
2. 關閉副作用後再執行
3. 避免選取整個世界高度（Y: -64 到 319）

---

## 常見問題

### Q: 保存後找不到檔案？

檔案位於：
```
~/minecraft-server/plugins/WorldEdit/schematics/
```

使用 `//schem list` 確認是否保存成功。

---

### Q: 貼上位置不對？

- 使用 `//paste -o` 貼到原始位置
- 或站在想要的位置使用 `//paste`

---

### Q: 伺服器卡頓或超時？

執行前先關閉副作用：
```bash
//perf neighbors off
//perf lighting off
```

---

### Q: 如何備份出生點？

```bash
# 1. 傳送到出生點
/tp -1012 84 -1237

# 2. 選取範圍
//pos1 -1060,-64,-1285
//pos2 -964,256,-1189

# 3. 複製並保存
//copy
//schem save spawn_backup_完整
```

---

### Q: 如何還原備份？

```bash
//schem load spawn_backup_完整
//paste -o
```

---

### Q: 檔案太大無法保存？

1. 減少選區範圍
2. 分成多個檔案保存
3. 增加伺服器記憶體

---

### Q: 如何與其他人分享 Schematic？

1. 從 `plugins/WorldEdit/schematics/` 複製 `.schem` 檔案
2. 傳送給對方
3. 對方放入相同資料夾
4. 使用 `//schem load` 載入

---

## 權限節點

| 權限 | 說明 |
|------|------|
| `worldedit.clipboard.copy` | 使用 //copy |
| `worldedit.clipboard.cut` | 使用 //cut |
| `worldedit.clipboard.paste` | 使用 //paste |
| `worldedit.schematic.save` | 保存 schematic |
| `worldedit.schematic.load` | 載入 schematic |
| `worldedit.schematic.delete` | 刪除 schematic |
| `worldedit.schematic.list` | 列出 schematic |

---

## 指令別名

許多指令有簡短版本：

| 完整指令 | 簡短版本 |
|----------|----------|
| `//schematic` | `//schem` |
| `//schematic save` | `//schem save` |
| `//schematic load` | `//schem load` |
| `//schematic list` | `//schem list` |
| `//schematic delete` | `//schem delete` |

---

## 快速參考卡

```
┌─────────────────────────────────────────────────────┐
│           WorldEdit Schematic 快速參考              │
├─────────────────────────────────────────────────────┤
│  保存流程：                                          │
│  //wand → 選取 → //copy → //schem save <名稱>      │
│                                                      │
│  載入流程：                                          │
│  //schem load <名稱> → //paste -o                   │
│                                                      │
│  常用選項：                                          │
│  -o  原始位置    -a  忽略空氣                        │
│  -e  包含實體    -b  包含生物群系                    │
│                                                      │
│  效能優化：                                          │
│  //perf neighbors off      # 關閉相鄰方塊更新         │
│  //perf lighting off     # 關閉光照重新計算          │
│  （執行操作後記得開回來）                            │

│  //perf neighbors on      # 開啟相鄰方塊更新         │
│  //perf lighting on     # 開啟光照重新計算          │
└─────────────────────────────────────────────────────┘
```

---

*文件版本：1.0*
*適用於 WorldEdit 7.4.0*
*最後更新：2026-03-24*
