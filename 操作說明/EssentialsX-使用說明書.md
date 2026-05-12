# ============================================
# EssentialsX 完整使用說明書
# ============================================
#
# EssentialsX 是 Minecraft 伺服器最重要的基礎插件
# 提供超過 100 個實用指令
#
# 官網：https://essentialsx.net/
# 文檔：https://essentialsx.net/wiki/
# GitHub：https://github.com/EssentialsX/Essentials
#
# ============================================


## 目錄

1. 插件簡介
2. 傳送指令
3. 家與地標
4. 玩家管理
5. 經濟系統
6. 物品指令
7. 聊天通訊
8. 時間與天氣
9. 遊戲模式
10. 實用工具
11. 管理員指令
12. 權限節點


# ============================================
# 1. 插件簡介
# ============================================

## EssentialsX 是什麼？

EssentialsX 是 Minecraft 伺服器的核心插件，提供：
- 傳送系統（/tp, /tpa, /spawn, /home）
- 經濟系統（/money, /pay, /bal）
- 管理指令（/ban, /kick, /mute）
- 實用工具（/heal, /feed, /fly）
- 聊天系統（/msg, /reply, /mail）

## 相關附加插件

| 插件 | 功能 |
|------|------|
| EssentialsX | 核心插件（必裝） |
| EssentialsXSpawn | 出生點管理 |
| EssentialsXChat | 聊天格式化 |
| EssentialsXGeoIP | IP 地理位置 |
| EssentialsXDiscord | Discord 連動 |


# ============================================
# 2. 傳送指令
# ============================================

## 基本傳送

| 指令 | 功能 | 範例 |
|------|------|------|
| /tp <玩家> | 傳送到玩家 | /tp Toast920821 |
| /tp <玩家A> <玩家B> | 將 A 傳送到 B | /tp Steve Alex |
| /tp <x> <y> <z> | 傳送到座標 | /tp 100 64 -200 |
| /tppos <x> <y> <z> | 傳送到精確座標 | /tppos 100.5 64 -200.5 |
| /tpall | 傳送所有玩家到你這 | /tpall |

## 傳送請求

| 指令 | 功能 | 範例 |
|------|------|------|
| /tpa <玩家> | 請求傳送到對方 | /tpa Toast920821 |
| /tpahere <玩家> | 請求對方傳送到你這 | /tpahere Toast920821 |
| /tpaccept | 接受傳送請求 | /tpaccept |
| /tpdeny | 拒絕傳送請求 | /tpdeny |
| /tpacancel | 取消傳送請求 | /tpacancel |
| /tpauto | 自動接受所有傳送請求 | /tpauto |
| /tptoggle | 開關傳送請求 | /tptoggle |

## 特殊傳送

| 指令 | 功能 | 範例 |
|------|------|------|
| /back | 回到上一個位置 | /back |
| /spawn | 回到出生點 | /spawn |
| /top | 傳送到最高方塊上方 | /top |
| /jump | 傳送到準心指向的位置 | /jump |
| /thru | 穿過牆壁 | /thru |
| /up <距離> | 向上傳送 | /up 10 |


# ============================================
# 3. 家與地標
# ============================================

## 家（Home）

| 指令 | 功能 | 範例 |
|------|------|------|
| /sethome | 設定家（預設名稱 home） | /sethome |
| /sethome <名稱> | 設定命名的家 | /sethome 礦坑 |
| /home | 回到家 | /home |
| /home <名稱> | 回到指定的家 | /home 礦坑 |
| /homes | 列出所有的家 | /homes |
| /delhome <名稱> | 刪除指定的家 | /delhome 礦坑 |

## 地標（Warp）

| 指令 | 功能 | 範例 |
|------|------|------|
| /setwarp <名稱> | 設定地標 | /setwarp 商店 |
| /warp <名稱> | 傳送到地標 | /warp 商店 |
| /warps | 列出所有地標 | /warps |
| /delwarp <名稱> | 刪除地標 | /delwarp 商店 |

## 出生點（Spawn）

| 指令 | 功能 | 範例 |
|------|------|------|
| /setspawn | 設定出生點 | /setspawn |
| /setspawn <群組> | 設定群組出生點 | /setspawn vip |
| /spawn | 傳送到出生點 | /spawn |
| /spawn <玩家> | 傳送玩家到出生點 | /spawn Toast920821 |


# ============================================
# 4. 玩家管理
# ============================================

## 封禁系統

| 指令 | 功能 | 範例 |
|------|------|------|
| /ban <玩家> [原因] | 永久封禁 | /ban Steve 作弊 |
| /tempban <玩家> <時間> [原因] | 暫時封禁 | /tempban Steve 1d 警告 |
| /unban <玩家> | 解除封禁 | /unban Steve |
| /banip <IP> | 封禁 IP | /banip 123.45.67.89 |
| /unbanip <IP> | 解除 IP 封禁 | /unbanip 123.45.67.89 |
| /banlist | 查看封禁列表 | /banlist |

### 時間格式

| 格式 | 意思 | 範例 |
|------|------|------|
| s | 秒 | 30s = 30 秒 |
| m | 分鐘 | 10m = 10 分鐘 |
| h | 小時 | 2h = 2 小時 |
| d | 天 | 7d = 7 天 |
| w | 週 | 1w = 1 週 |
| mo | 月 | 1mo = 1 個月 |
| y | 年 | 1y = 1 年 |

範例：
```
/tempban Steve 30m 違規
/tempban Steve 1d12h 多次警告
/tempban Steve 1w 嚴重違規
```

## 踢出與禁言

| 指令 | 功能 | 範例 |
|------|------|------|
| /kick <玩家> [原因] | 踢出玩家 | /kick Steve 違規 |
| /kickall [原因] | 踢出所有玩家 | /kickall 維護中 |
| /mute <玩家> [時間] | 禁言玩家 | /mute Steve 10m |
| /unmute <玩家> | 解除禁言 | /unmute Steve |

## 監獄系統

| 指令 | 功能 | 範例 |
|------|------|------|
| /setjail <名稱> | 設定監獄位置 | /setjail 地牢 |
| /jail <玩家> <監獄> [時間] | 關押玩家 | /jail Steve 地牢 1h |
| /unjail <玩家> | 釋放玩家 | /unjail Steve |
| /jails | 列出所有監獄 | /jails |
| /deljail <名稱> | 刪除監獄 | /deljail 地牢 |

## 玩家資訊

| 指令 | 功能 | 範例 |
|------|------|------|
| /whois <玩家> | 查看玩家詳細資訊 | /whois Steve |
| /seen <玩家> | 查看玩家上次上線 | /seen Steve |
| /list | 列出在線玩家 | /list |
| /ping <玩家> | 查看玩家延遲 | /ping Steve |
| /near | 查看附近玩家 | /near |
| /realname <暱稱> | 查看暱稱對應的玩家 | /realname 小明 |


# ============================================
# 5. 經濟系統
# ============================================

## 基本經濟

| 指令 | 功能 | 範例 |
|------|------|------|
| /bal | 查看自己餘額 | /bal |
| /bal <玩家> | 查看玩家餘額 | /bal Steve |
| /balance | 同上 | /balance |
| /pay <玩家> <金額> | 轉帳 | /pay Steve 100 |
| /baltop | 財富排行榜 | /baltop |

## 管理員經濟指令

| 指令 | 功能 | 範例 |
|------|------|------|
| /eco give <玩家> <金額> | 給錢 | /eco give Steve 1000 |
| /eco take <玩家> <金額> | 扣錢 | /eco take Steve 500 |
| /eco set <玩家> <金額> | 設定餘額 | /eco set Steve 5000 |
| /eco reset <玩家> | 重置餘額 | /eco reset Steve |

## 經濟設定

編輯 `plugins/Essentials/config.yml`：

```yaml
# 起始金錢
starting-balance: 100

# 貨幣符號
currency-symbol: '$'

# 最大金額
max-money: 10000000000000

# 最小金額（可為負數）
min-money: -10000
```


# ============================================
# 6. 物品指令
# ============================================

## 給予物品

| 指令 | 功能 | 範例 |
|------|------|------|
| /give <玩家> <物品> [數量] | 給予物品 | /give Steve diamond 64 |
| /item <物品> [數量] | 給自己物品 | /item diamond 64 |
| /i <物品> [數量] | 同上（簡寫） | /i diamond 64 |

## 物品管理

| 指令 | 功能 | 範例 |
|------|------|------|
| /clear [玩家] | 清空背包 | /clear Steve |
| /clearinventory | 清空自己背包 | /clearinventory |
| /hat | 將手中物品戴在頭上 | /hat |
| /more | 將手中物品補滿到 64 | /more |
| /unlimited <物品> | 無限使用物品 | /unlimited diamond |
| /repair | 修復手中物品 | /repair |
| /repair all | 修復所有物品 | /repair all |

## 附魔

| 指令 | 功能 | 範例 |
|------|------|------|
| /enchant <附魔> <等級> | 附魔手中物品 | /enchant sharpness 5 |

常用附魔：
```
/enchant sharpness 5       # 鋒利 5
/enchant unbreaking 3      # 耐久 3
/enchant efficiency 5      # 效率 5
/enchant fortune 3         # 幸運 3
/enchant protection 4      # 保護 4
/enchant mending 1         # 修補 1
```

## 工具箱

| 指令 | 功能 | 範例 |
|------|------|------|
| /workbench | 開啟工作台 | /workbench |
| /craft | 同上 | /craft |
| /anvil | 開啟鐵砧 | /anvil |
| /enderchest | 開啟乾末影箱 | /enderchest |
| /ec | 同上（簡寫） | /ec |
| /disposal | 開啟垃圾桶 | /disposal |


# ============================================
# 7. 聊天通訊
# ============================================

## 私訊

| 指令 | 功能 | 範例 |
|------|------|------|
| /msg <玩家> <訊息> | 私訊玩家 | /msg Steve 你好！ |
| /tell <玩家> <訊息> | 同上 | /tell Steve 你好！ |
| /w <玩家> <訊息> | 同上（簡寫） | /w Steve 你好！ |
| /r <訊息> | 回覆上一個私訊 | /r 好的！ |
| /reply <訊息> | 同上 | /reply 好的！ |

## 郵件

| 指令 | 功能 | 範例 |
|------|------|------|
| /mail send <玩家> <訊息> | 發送郵件 | /mail send Steve 記得上線！ |
| /mail read | 讀取郵件 | /mail read |
| /mail clear | 清空郵件 | /mail clear |
| /mail sendall <訊息> | 發送給所有人 | /mail sendall 公告！ |

## 廣播

| 指令 | 功能 | 範例 |
|------|------|------|
| /broadcast <訊息> | 廣播訊息 | /broadcast 伺服器即將重啟！ |
| /bc <訊息> | 同上（簡寫） | /bc 維護通知！ |

## 暱稱

| 指令 | 功能 | 範例 |
|------|------|------|
| /nick <暱稱> | 設定自己暱稱 | /nick 小明 |
| /nick <玩家> <暱稱> | 設定玩家暱稱 | /nick Steve 小明 |
| /nick off | 移除暱稱 | /nick off |

## 社交

| 指令 | 功能 | 範例 |
|------|------|------|
| /ignore <玩家> | 忽略玩家訊息 | /ignore Steve |
| /unignore <玩家> | 取消忽略 | /unignore Steve |
| /helpop <訊息> | 向管理員求助 | /helpop 有人在作弊！ |
| /afk | 設為離開狀態 | /afk |
| /afk <訊息> | 設為離開並留言 | /afk 吃飯中 |


# ============================================
# 8. 時間與天氣
# ============================================

## 時間

| 指令 | 功能 | 範例 |
|------|------|------|
| /time set day | 設為白天 | /time set day |
| /time set night | 設為夜晚 | /time set night |
| /time set noon | 設為中午 | /time set noon |
| /time set midnight | 設為午夜 | /time set midnight |
| /time set <數值> | 設為指定時間 | /time set 6000 |
| /day | 快速設為白天 | /day |
| /night | 快速設為夜晚 | /night |
| /ptime <時間> | 設定個人時間 | /ptime day |
| /ptime reset | 重置個人時間 | /ptime reset |

### 時間數值對照

| 時間 | 數值 |
|------|------|
| 日出 | 0 |
| 中午 | 6000 |
| 日落 | 12000 |
| 午夜 | 18000 |

## 天氣

| 指令 | 功能 | 範例 |
|------|------|------|
| /weather sun | 設為晴天 | /weather sun |
| /weather storm | 設為暴風雨 | /weather storm |
| /weather rain | 設為下雨 | /weather rain |
| /sun | 快速設為晴天 | /sun |
| /storm | 快速設為暴風雨 | /storm |
| /rain | 快速設為下雨 | /rain |
| /thunder | 打雷 | /thunder |
| /pweather <天氣> | 設定個人天氣 | /pweather sun |
| /pweather reset | 重置個人天氣 | /pweather reset |


# ============================================
# 9. 遊戲模式
# ============================================

## 切換模式

| 指令 | 功能 | 範例 |
|------|------|------|
| /gamemode survival | 生存模式 | /gms |
| /gamemode creative | 創造模式 | /gmc |
| /gamemode adventure | 冒險模式 | /gma |
| /gamemode spectator | 旁觀模式 | /gmsp |

## 簡寫

| 指令 | 功能 |
|------|------|
| /gm 0 | 生存模式 |
| /gm 1 | 創造模式 |
| /gm 2 | 冒險模式 |
| /gm 3 | 旁觀模式 |
| /gms | 生存模式 |
| /gmc | 創造模式 |
| /gma | 冒險模式 |
| /gmsp | 旁觀模式 |

## 對其他玩家

```
/gms Steve          # 將 Steve 設為生存模式
/gmc Steve          # 將 Steve 設為創造模式
```


# ============================================
# 10. 實用工具
# ============================================

## 生存工具

| 指令 | 功能 | 範例 |
|------|------|------|
| /heal [玩家] | 回滿血量 | /heal |
| /feed [玩家] | 回滿飢餓 | /feed |
| /fly | 開關飛行 | /fly |
| /fly <玩家> | 開關玩家飛行 | /fly Steve |
| /god | 開關無敵 | /god |
| /god <玩家> | 開關玩家無敵 | /god Steve |
| /speed <數值> | 設定移動速度 | /speed 2 |
| /flyspeed <數值> | 設定飛行速度 | /flyspeed 2 |
| /walkspeed <數值> | 設定走路速度 | /walkspeed 2 |

## 顯示工具

| 指令 | 功能 | 範例 |
|------|------|------|
| /compass | 顯示面向方位 | /compass |
| /depth | 顯示海平面高度 | /depth |
| /getpos | 顯示座標 | /getpos |
| /biome | 顯示所在生態系 | /biome |

## 實用功能

| 指令 | 功能 | 範例 |
|------|------|------|
| /exp show | 顯示經驗值 | /exp show |
| /exp give <玩家> <數量> | 給予經驗 | /exp give Steve 100 |
| /exp set <玩家> <數量> | 設定經驗 | /exp set Steve 1000 |
| /suicide | 自殺 | /suicide |
| /kill <玩家> | 殺死玩家 | /kill Steve |
| /nuke | 對附近區域發射閃電 | /nuke |

## 隱身

| 指令 | 功能 | 範例 |
|------|------|------|
| /vanish | 隱身/取消隱身 | /vanish |
| /v | 同上（簡寫） | /v |

## 書寫工具

| 指令 | 功能 | 範例 |
|------|------|------|
| /book | 編輯書本標題和作者 | /book |
| /editsign <行數> <文字> | 編輯告示牌 | /editsign 1 歡迎！ |


# ============================================
# 11. 管理員指令
# ============================================

## 伺服器管理

| 指令 | 功能 | 範例 |
|------|------|------|
| /essentials | 查看 Essentials 版本 | /essentials |
| /essentials reload | 重載配置 | /ess reload |
| /gc | 查看伺服器資源使用 | /gc |
| /mem | 查看記憶體使用 | /mem |
| /tps | 查看 TPS | /tps |

## 世界管理

| 指令 | 功能 | 範例 |
|------|------|------|
| /world <世界名> | 傳送到指定世界 | /world world_nether |
| /setspawn | 設定出生點 | /setspawn |
| /setworldspawn | 設定世界出生點 | /setworldspawn |

## 玩家管理

| 指令 | 功能 | 範例 |
|------|------|------|
| /invsee <玩家> | 查看玩家背包 | /invsee Steve |
| /enderchest <玩家> | 查看玩家乾末影箱 | /enderchest Steve |
| /sudo <玩家> <指令> | 強制玩家執行指令 | /sudo Steve say 你好 |

## 維護模式

編輯 `plugins/Essentials/config.yml`：

```yaml
# 啟用維護模式（只有有權限的人可以加入）
# 使用 /essentials reload 重載
```


# ============================================
# 12. 權限節點
# ============================================

## 常用權限

| 權限 | 功能 |
|------|------|
| essentials.tp | 使用 /tp |
| essentials.tpa | 使用 /tpa |
| essentials.home | 使用 /home |
| essentials.sethome | 使用 /sethome |
| essentials.spawn | 使用 /spawn |
| essentials.warp | 使用 /warp |
| essentials.back | 使用 /back |

## 管理權限

| 權限 | 功能 |
|------|------|
| essentials.ban | 使用 /ban |
| essentials.kick | 使用 /kick |
| essentials.mute | 使用 /mute |
| essentials.heal | 使用 /heal |
| essentials.fly | 使用 /fly |
| essentials.god | 使用 /god |
| essentials.vanish | 使用 /vanish |

## 經濟權限

| 權限 | 功能 |
|------|------|
| essentials.balance | 使用 /bal |
| essentials.balance.others | 查看他人餘額 |
| essentials.pay | 使用 /pay |
| essentials.eco | 使用 /eco |

## 特殊權限

| 權限 | 功能 |
|------|------|
| essentials.silentjoin | 靜默加入 |
| essentials.silentquit | 靜默離開 |
| essentials.vanish.onjoin | 加入時自動隱身 |
| essentials.sethome.multiple | 設定多個家 |
| essentials.sethome.multiple.<數量> | 設定指定數量的家 |

## 給予權限範例

```
# 給玩家基本權限
/lp user Steve permission set essentials.home true
/lp user Steve permission set essentials.sethome true
/lp user Steve permission set essentials.spawn true

# 給群組權限
/lp group default permission set essentials.home true
/lp group default permission set essentials.sethome true
/lp group default permission set essentials.spawn true
/lp group default permission set essentials.tpa true

# 給 VIP 多個家
/lp group vip permission set essentials.sethome.multiple.5 true

# 給管理員所有權限
/lp group admin permission set essentials.* true
```


# ============================================
# 快速參考卡
# ============================================

## 玩家常用

```
/home               # 回家
/sethome            # 設定家
/spawn              # 回出生點
/tpa 玩家           # 請求傳送
/tpaccept           # 接受傳送
/back               # 回到上一個位置
/bal                # 查看餘額
/pay 玩家 金額      # 轉帳
```

## 管理員常用

```
/ban 玩家 原因      # 封禁
/tempban 玩家 1d    # 暫封 1 天
/kick 玩家 原因     # 踢出
/mute 玩家 10m      # 禁言 10 分鐘
/heal 玩家          # 回血
/fly 玩家           # 飛行
/vanish             # 隱身
/invsee 玩家        # 查看背包
```

## 經濟管理

```
/eco give 玩家 1000 # 給錢
/eco take 玩家 500  # 扣錢
/eco set 玩家 5000  # 設定餘額
```


# ============================================
# 結語
# ============================================

EssentialsX 是伺服器必備的基礎插件，
掌握這些指令可以讓你更有效地管理伺服器！

更多資訊請參考官方文檔：
https://essentialsx.net/wiki/
