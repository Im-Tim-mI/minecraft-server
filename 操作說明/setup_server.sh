# 安裝 Java 21
sudo apt install openjdk-21-jdk -y

# 檢測安裝是否正常
java -version

# 創建目錄並進入
mkdir -p ./minecraft-server 
cd ./minecraft-server

# 創建必要目錄
mkdir -p plugins

# 下載 Paper 服務器
echo "下載 Paper 服務器1.21.11-99..."
curl -L -o server.jar "https://fill-data.papermc.io/v1/objects/84f4283253ae7e50a25b26ef3b03d57818145534fb0c8a27925b7bae59222ba6/paper-1.21.11-99.jar"
#curl -L -o server.jar "https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/224/downloads/paper-1.21.4-224.jar"


# 下載插件
#基岩版跨平台插件
echo "下載 Geyser..."
curl -L -o plugins/Geyser-Spigot.jar "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

#基岩版免java帳號登入插件
echo "下載 Floodgate..."
curl -L -o plugins/Floodgate-Spigot.jar "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

#快速建造腳本
#echo "下載 WorldEdit..."
#curl -L -o plugins/WorldEdit.jar "https://mediafilez.forgecdn.net/files/6091/51/worldedit-bukkit-7.3.10.jar"

# 同意 EULA
echo "eula=true" > eula.txt

# 創建啟動腳本
echo '#!/bin/bash
java -Xmx4G -Xms2G -jar server.jar nogui' > start.sh
chmod +x start.sh

echo "完成！執行 ./start.sh 啟動服務器"