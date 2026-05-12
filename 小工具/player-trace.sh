# 玩家連鎖追蹤程式
# 基本用法
# ./player-trace.sh <玩家名稱>
# 設定追蹤深度（預設 3 層）
# ./player-trace.sh <玩家名稱> 5

# ./player-trace.sh kkuuuzzzz 5

#!/bin/bash
# ============================================
# 玩家關聯追蹤工具
# 追蹤玩家 → IP → 其他玩家 → 更多 IP...
# ============================================

LOGS_DIR="$HOME/minecraft-server/logs"
USERDATA_DIR="$HOME/minecraft-server/plugins/Essentials/userdata"

# 最大追蹤深度（防止無限循環）
MAX_DEPTH=3

# 已搜尋過的玩家和 IP（避免重複）
declare -A SEARCHED_PLAYERS
declare -A SEARCHED_IPS
declare -A PLAYER_IPS
declare -A IP_PLAYERS

# 顏色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ============================================
# 函數：取得玩家的所有 IP
# ============================================
get_player_ips() {
    local player="$1"
    local ips=""
    
    # 從 Essentials userdata 取得
    local userfile="$USERDATA_DIR/$player.yml"
    if [ -f "$userfile" ]; then
        local essip=$(grep "ipAddress:" "$userfile" 2>/dev/null | head -1 | awk '{print $2}')
        if [ ! -z "$essip" ]; then
            ips="$essip"
        fi
    fi
    
    # 從日誌取得更多 IP
    local log_ips=$(
        {
            zgrep -h "$player\[/" "$LOGS_DIR"/*.log.gz 2>/dev/null
            grep "$player\[/" "$LOGS_DIR/latest.log" 2>/dev/null
        } | grep -i "logged in" | grep -oP '\[/\K[0-9.]+' | sort -u
    )
    
    # 合併並去重
    echo "$ips $log_ips" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ' '
}

# ============================================
# 函數：取得 IP 的所有玩家
# ============================================
get_ip_players() {
    local ip="$1"
    local players=""
    
    # 從 Essentials userdata 搜尋
    for file in "$USERDATA_DIR"/*.yml; do
        if [ -f "$file" ]; then
            if grep -q "ipAddress: $ip" "$file" 2>/dev/null; then
                local name=$(basename "$file" .yml)
                players="$players $name"
            fi
        fi
    done
    
    # 從日誌搜尋
    local log_players=$(
        {
            zgrep -h "/$ip:" "$LOGS_DIR"/*.log.gz 2>/dev/null
            grep "/$ip:" "$LOGS_DIR/latest.log" 2>/dev/null
        } | grep -i "logged in" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}' | sort -u
    )
    
    # 合併並去重
    echo "$players $log_players" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ' '
}

# ============================================
# 函數：取得 IP 的登入記錄（含日期）
# ============================================
get_ip_login_history() {
    local ip="$1"
    
    # 搜尋壓縮日誌
    for logfile in "$LOGS_DIR"/*.log.gz; do
        if [ -f "$logfile" ]; then
            filename=$(basename "$logfile")
            date=$(echo "$filename" | grep -oP '^\d{4}-\d{2}-\d{2}')
            
            zgrep "/$ip:" "$logfile" 2>/dev/null | grep -i "logged in" | while read line; do
                time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
                player=$(echo "$line" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}')
                echo "$date $time $player"
            done
        fi
    done
    
    # 搜尋當前日誌
    today=$(date "+%Y-%m-%d")
    grep "/$ip:" "$LOGS_DIR/latest.log" 2>/dev/null | grep -i "logged in" | while read line; do
        time=$(echo "$line" | grep -oP '^\[\K[0-9:]+')
        player=$(echo "$line" | grep -oP 'INFO\]: \K[^\[]+' | awk '{print $1}')
        echo "$today $time $player"
    done
}

# ============================================
# 函數：遞迴追蹤
# ============================================
trace_player() {
    local player="$1"
    local depth="$2"
    local indent=""
    
    # 建立縮排
    for ((i=0; i<depth; i++)); do
        indent="$indent    "
    done
    
    # 檢查是否超過最大深度
    if [ $depth -ge $MAX_DEPTH ]; then
        echo -e "${indent}${YELLOW}⚠ 達到最大追蹤深度，停止追蹤${NC}"
        return
    fi
    
    # 檢查是否已經搜尋過
    if [ "${SEARCHED_PLAYERS[$player]}" == "1" ]; then
        echo -e "${indent}${PURPLE}↺ $player（已搜尋過，跳過）${NC}"
        return
    fi
    
    # 標記為已搜尋
    SEARCHED_PLAYERS[$player]="1"
    
    # 取得玩家的所有 IP
    local ips=$(get_player_ips "$player")
    
    if [ -z "$ips" ]; then
        echo -e "${indent}${RED}✗ $player - 找不到任何 IP 記錄${NC}"
        return
    fi
    
    echo -e "${indent}${GREEN}▼ $player${NC}"
    
    # 對每個 IP 進行追蹤
    for ip in $ips; do
        [ -z "$ip" ] && continue
        
        # 儲存玩家-IP 關聯
        PLAYER_IPS["$player"]="${PLAYER_IPS[$player]} $ip"
        
        echo -e "${indent}    ${CYAN}├─ IP: $ip${NC}"
        
        # 檢查是否已經搜尋過此 IP
        if [ "${SEARCHED_IPS[$ip]}" == "1" ]; then
            echo -e "${indent}    ${PURPLE}│  ↺ （此 IP 已搜尋過）${NC}"
            continue
        fi
        
        # 標記 IP 為已搜尋
        SEARCHED_IPS[$ip]="1"
        
        # 取得此 IP 的所有玩家
        local ip_players=$(get_ip_players "$ip")
        
        for other_player in $ip_players; do
            [ -z "$other_player" ] && continue
            
            # 儲存 IP-玩家 關聯
            IP_PLAYERS["$ip"]="${IP_PLAYERS[$ip]} $other_player"
            
            if [ "$other_player" != "$player" ]; then
                if [ "${SEARCHED_PLAYERS[$other_player]}" == "1" ]; then
                    echo -e "${indent}    ${PURPLE}│  ↺ $other_player（已搜尋過）${NC}"
                else
                    echo -e "${indent}    ${YELLOW}│  → 發現關聯玩家: $other_player${NC}"
                    # 遞迴追蹤
                    trace_player "$other_player" $((depth + 1))
                fi
            fi
        done
    done
}

# ============================================
# 函數：顯示摘要報告
# ============================================
show_summary() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                      追蹤摘要報告                             ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    # 所有關聯玩家
    echo -e "${GREEN}【所有關聯玩家】${NC}"
    echo "=================================================================="
    local player_count=0
    for player in "${!SEARCHED_PLAYERS[@]}"; do
        ((player_count++))
        echo "  $player_count. $player"
    done
    echo ""
    echo "  共 $player_count 個關聯帳號"
    echo ""
    
    # 所有關聯 IP
    echo -e "${CYAN}【所有關聯 IP】${NC}"
    echo "=================================================================="
    local ip_count=0
    for ip in "${!SEARCHED_IPS[@]}"; do
        ((ip_count++))
        local players="${IP_PLAYERS[$ip]}"
        local player_list=$(echo "$players" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ', ' | sed 's/,$//')
        echo "  $ip_count. $ip"
        echo "      玩家: $player_list"
    done
    echo ""
    echo "  共 $ip_count 個關聯 IP"
    echo ""
    
    # 關聯圖
    echo -e "${YELLOW}【關聯圖】${NC}"
    echo "=================================================================="
    for player in "${!SEARCHED_PLAYERS[@]}"; do
        local ips="${PLAYER_IPS[$player]}"
        if [ ! -z "$ips" ]; then
            local ip_list=$(echo "$ips" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ', ' | sed 's/,$//')
            echo "  $player"
            echo "    └─ IP: $ip_list"
        fi
    done
    echo ""
    
    # 登入歷史
    echo -e "${PURPLE}【最近登入記錄】${NC}"
    echo "=================================================================="
    for ip in "${!SEARCHED_IPS[@]}"; do
        echo "  IP: $ip"
        get_ip_login_history "$ip" | sort | tail -5 | while read record; do
            echo "    $record"
        done
        echo ""
    done
}

# ============================================
# 函數：匯出報告
# ============================================
export_report() {
    local output_file="$HOME/minecraft-server/小工具/player-trace-report-$START_PLAYER-$(date +%Y%m%d-%H%M%S).txt"
    
    {
        echo "============================================"
        echo "玩家關聯追蹤報告"
        echo "起始玩家: $START_PLAYER"
        echo "產生時間: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "============================================"
        echo ""
        
        echo "【所有關聯玩家】"
        for player in "${!SEARCHED_PLAYERS[@]}"; do
            echo "  - $player"
        done
        echo ""
        
        echo "【所有關聯 IP】"
        for ip in "${!SEARCHED_IPS[@]}"; do
            local players="${IP_PLAYERS[$ip]}"
            local player_list=$(echo "$players" | tr ' ' '\n' | grep -v '^$' | sort -u | tr '\n' ', ' | sed 's/,$//')
            echo "  $ip -> $player_list"
        done
        echo ""
        
        echo "【完整登入記錄】"
        for ip in "${!SEARCHED_IPS[@]}"; do
            echo "IP: $ip"
            get_ip_login_history "$ip" | sort
            echo ""
        done
        
    } > "$output_file"
    
    echo -e "${GREEN}報告已匯出到: $output_file${NC}"
}

# ============================================
# 主程式
# ============================================
main() {
    local player="$1"
    
    if [ -z "$player" ]; then
        echo ""
        echo "用法: $0 <玩家名稱> [最大深度]"
        echo ""
        echo "範例:"
        echo "  $0 kkuuuzzzz       # 追蹤 kkuuuzzzz 的所有關聯"
        echo "  $0 kkuuuzzzz 5     # 追蹤深度設為 5"
        echo ""
        exit 1
    fi
    
    # 設定最大深度（如果有提供）
    if [ ! -z "$2" ]; then
        MAX_DEPTH="$2"
    fi
    
    START_PLAYER="$player"
    
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║              玩家關聯追蹤工具 v1.0                            ║${NC}"
    echo -e "${BLUE}╠══════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE}║  起始玩家: $player${NC}"
    echo -e "${BLUE}║  最大深度: $MAX_DEPTH${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    
    echo -e "${YELLOW}正在追蹤關聯...${NC}"
    echo ""
    
    # 開始追蹤
    trace_player "$player" 0
    
    # 顯示摘要
    show_summary
    
    # 詢問是否匯出
    echo -e "${CYAN}是否匯出報告到檔案？(y/n)${NC}"
    read -r answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
        export_report
    fi
}

# 執行主程式
main "$@"
