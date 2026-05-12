# 查看玩家所有登入過的 IP地址，包含时间戳，并列出不重复的 IP 地址列表。
# 使用方法: ./player-ip-history.sh <玩家名稱>
#!/bin/bash

PLAYER="$1"
LOGS_DIR="$HOME/minecraft-server/logs"

if [ -z "$PLAYER" ]; then
    echo "用法: ./player-ip-history.sh <玩家名稱>"
    exit 1
fi

echo "=========================================="
echo "玩家: $PLAYER"
echo "=========================================="
echo ""
echo "【所有登入記錄（含時間）】"
echo "------------------------------------------"

# 搜尋壓縮日誌
for logfile in "$LOGS_DIR"/*.log.gz; do
    if [ -f "$logfile" ]; then
        zgrep -H "$PLAYER.*logged in" "$logfile" 2>/dev/null | while read line; do
            date=$(basename "$logfile" .log.gz)
            time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
            ip=$(echo "$line" | grep -oP '\[/\K[0-9.]+')
            echo "$date $time - IP: $ip"
        done
    fi
done

# 搜尋當前日誌
grep "$PLAYER.*logged in" "$LOGS_DIR/latest.log" 2>/dev/null | while read line; do
    time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
    ip=$(echo "$line" | grep -oP '\[/\K[0-9.]+')
    echo "today $time - IP: $ip"
done

echo ""
echo "【不重複的 IP 列表】"
echo "------------------------------------------"

{
    zgrep -h "$PLAYER.*logged in" "$LOGS_DIR"/*.log.gz 2>/dev/null
    grep "$PLAYER.*logged in" "$LOGS_DIR/latest.log" 2>/dev/null
} | grep -oP '\[/\K[0-9.]+' | sort -u

echo ""
echo "=========================================="
