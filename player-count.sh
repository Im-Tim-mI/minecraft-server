#!/bin/bash
# 檔案：~/minecraft-server/player-count.sh

echo "═══════════════════════════════════"
echo "       伺服器玩家統計"
echo "═══════════════════════════════════"

# 從 usercache.json
if [ -f ~/minecraft-server/usercache.json ]; then
    CACHE_COUNT=$(cat ~/minecraft-server/usercache.json | grep -o '"name"' | wc -l)
    echo "usercache.json 記錄：$CACHE_COUNT 人"
fi

# 從 playerdata
if [ -d ~/minecraft-server/world/playerdata ]; then
    DATA_COUNT=$(ls ~/minecraft-server/world/playerdata/*.dat 2>/dev/null | wc -l)
    echo "playerdata 資料夾：$DATA_COUNT 人"
fi

# 從 Essentials
if [ -d ~/minecraft-server/plugins/Essentials/userdata ]; then
    ESS_COUNT=$(ls ~/minecraft-server/plugins/Essentials/userdata/*.yml 2>/dev/null | wc -l)
    echo "Essentials 記錄：$ESS_COUNT 人"
fi

echo "═══════════════════════════════════"