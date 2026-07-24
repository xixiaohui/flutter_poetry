#!/bin/bash
# Flutter Web 调试启动脚本
# 解决 Windows 上 Chrome 主配置文件损坏导致 502/调试端口连接失败的问题

CHROME_PROFILE="$TEMP/flutter_chrome_profile"

echo "清理旧进程..."
taskkill //F //IM "chrome.exe" 2>/dev/null
sleep 1

echo "准备独立 Chrome 配置..."
rm -rf "$CHROME_PROFILE" 2>/dev/null
mkdir -p "$CHROME_PROFILE"

echo "启动 Flutter Web..."
cd "$(dirname "$0")/.."
flutter run -d chrome \
  --web-browser-flag="--user-data-dir=$CHROME_PROFILE" \
  --web-browser-flag="--no-first-run" \
  --web-browser-flag="--disable-extensions"
