
#!/usr/bin/env bash
# THDN-PrintServer 一键编译脚本
# 适用于 AR9531/9533 芯片，固件 ≤16MB，集成 CUPS + HP 驱动

set -euo pipefail

OPENWRT_REPO="https://github.com/openwrt/openwrt.git"
OPENWRT_BRANCH="openwrt-21.02"
FEEDS_CONF="feeds.conf"
CONFIG_FILE="config/ar9531_defconfig"
FILES_DIR="$PWD/files"

# 检查依赖
command -v git >/dev/null 2>&1 || { echo "❌ 请先安装 git"; exit 1; }
command -v wget >/dev/null 2>&1 || { echo "❌ 请先安装 wget"; exit 1; }

# 克隆源码
if [ ! -d "openwrt" ]; then
    echo "🧰 克隆 OpenWrt 源码（分支：$OPENWRT_BRANCH）"
    git clone --depth 1 --branch "$OPENWRT_BRANCH" "$OPENWRT_REPO" openwrt
fi

cd openwrt

# 替换 feeds 源为中科大镜像
echo "🌐 替换 feeds 源为中科大镜像"
cp ../feeds.conf feeds.conf

# 更新并安装 feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 应用精简配置
echo "⚙️ 应用精简配置（≤16MB）"
cp "../$CONFIG_FILE" .config
make defconfig

# 植入自定义文件
if [ -d "$FILES_DIR" ]; then
    echo "📁 植入自定义配置与脚本"
    cp -r "$FILES_DIR"/* files/
fi

# 开始编译
echo "🔨 开始编译（-j$(nproc)）"
make download -j$(nproc) V=s
make -j$(nproc) V=s

echo "✅ 编译完成！固件位于：bin/targets/ath79/generic/"
