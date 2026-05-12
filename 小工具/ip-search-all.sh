# IP 搜尋工具 - 完整報告
# 使用方法: ./ip-search-all.sh <IP地址>
#!/bin/bash

IP="$1"

if [ -z "$IP" ]; then
    echo "用法: ./ip-search-all.sh <IP地址>"
    exit 1
fi

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║           IP 搜尋工具 - 完整報告                  ║"
echo "║           搜尋 IP: $IP"
echo "╚══════════════════════════════════════════════════╝"
echo ""

# 1. Essentials userdata
echo "【1. Essentials 記錄】"
echo "=================================================="
USERDATA_DIR="$HOME/minecraft-server/plugins/Essentials/userdata"
count=0
for file in "$USERDATA_DIR"/*.yml; do
    if grep -q "ipAddress: $IP" "$file" 2>/dev/null; then
        name=$(basename "$file" .yml)
        echo "  ✓ $name"
        ((count++))
    fi
done
if [ $count -eq 0 ]; then
    echo "  （無記錄）"
fi
echo ""

# 2. 伺服器日誌
echo "【2. 伺服器日誌記錄】"
echo "=================================================="
LOGS_DIR="$HOME/minecraft-server/logs"
{
    zgrep -h "/$IP:" "$LOGS_DIR"/*.log.gz 2>/dev/null
    grep "/$IP:" "$LOGS_DIR/latest.log" 2>/dev/null
} | grep -i "logged in" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}' | sort -u | while read player; do
    echo "  ✓ $player"
done
echo ""

# 3. 登入時間記錄（含日期）
echo "【3. 最近登入記錄（此 IP）】"
echo "=================================================="
LOGS_DIR="$HOME/minecraft-server/logs"

# 搜尋壓縮日誌（從檔名取得日期）
for logfile in "$LOGS_DIR"/*.log.gz; do
    if [ -f "$logfile" ]; then
        # 從檔名提取日期（例如 2026-04-10-1.log.gz -> 2026-04-10）
        filename=$(basename "$logfile")
        date=$(echo "$filename" | grep -oP '^\d{4}-\d{2}-\d{2}')
        
        zgrep "/$IP:" "$logfile" 2>/dev/null | grep -i "logged in" | while read line; do
            time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
            player=$(echo "$line" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}')
            echo "  $date $time - $player"
        done
    fi
done | sort | tail -20

# 搜尋當前日誌
today=$(date "+%Y-%m-%d")
grep "/$IP:" "$LOGS_DIR/latest.log" 2>/dev/null | grep -i "logged in" | while read line; do
    time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
    player=$(echo "$line" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}')
    echo "  $today $time - $player (今天)"
done

echo ""
echo "=================================================="
echo "搜尋完成"
echo "=================================================="
