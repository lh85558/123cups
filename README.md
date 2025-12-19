
# THDN-PrintServer LEDE 固件定制项目

基于 AR9531/9533 芯片的 OpenWrt/LEDE 固件，集成 CUPS 2.4.2 中文打印服务，预装 HP LaserJet 驱动，支持 USB/网络打印、远程打印、定时重启、AP 模式切换。

## ✅ 功能特性

- ✅ 固件体积 ≤16MB，适用于 16MB Flash 路由器  
- ✅ 使用中国科学技术大学国内源加速构建  
- ✅ 集成 CUPS 2.4.2 中文打印服务  
- ✅ 预装 HP LaserJet 1020/1020plus/1007/1008/1108 驱动  
- ✅ 支持 USB 打印机、网络打印机、远程打印  
- ✅ 支持定时重启（cron 定时任务）  
- ✅ 支持一键切换无线 AP 模式  
- ✅ 默认 LAN IP：192.168.10.1  
- ✅ Web 登录：admin / thdn12345678  
- ✅ Wi-Fi SSID：THDN-dayin，密码：thdn12345678  
- ✅ 主机名：THDN-PrintServer  

## 🧰 项目结构

```
THDN-PrintServer/
├── build.sh                 # 一键本地编译脚本
├── .github/
│   └── workflows/
│       └── build.yml        # GitHub Actions 云编译脚本
├── config/
│   └── ar9531_defconfig     # 精简版 .config（≤16MB）
├── files/
│   ├── etc/
│   │   ├── config/
│   │   │   ├── network      # 网络配置（LAN IP 192.168.10.1）
│   │   │   ├── wireless     # Wi-Fi 配置（THDN-dayin）
│   │   │   ├── cupsd        # CUPS 服务配置
│   │   │   └── system       # 主机名与定时重启
│   │   ├── cups/
│   │   │   ├── cupsd.conf   # CUPS 主配置（中文界面）
│   │   │   └── ppd/         # 预装 HP 驱动 PPD 文件
│   │   ├── uci-defaults/
│   │   │   ├── 90-thdn-reboot      # 定时重启脚本
│   │   │   └── 90-thdn-apmode      # AP 模式切换脚本
│   │   └── shadow              # 默认密码（admin/thdn12345678）
├── feeds.conf                 # 国内源配置（中科大镜像）
└── README.md                  # 项目说明文档
```

## 🚀 使用方法

### 本地编译（推荐 Ubuntu 22.04）

```bash
sudo apt update && sudo apt install -y build-essential ccache ecj fastjar file g++ gawk \
gettext git java-propose-classpath libelf-dev libncurses5-dev libncursesw5-dev libssl-dev \
python python2.7-dev python3 unzip wget python3-distutils python3-setuptools python3-dev \
rsync subversion swig time xsltproc zlib1g-dev

git clone https://github.com/yourname/THDN-PrintServer.git
cd THDN-PrintServer
./build.sh
```

构建完成后，固件位于 `openwrt/bin/targets/ath79/generic/`

### 云编译（GitHub Actions）

1. Fork 本仓库  
2. 进入 Actions 页面，手动触发 `Build LEDE Firmware` 工作流  
3. 构建完成后，固件将以 Artifact 形式下载（使用 actions/upload-artifact@v4）

## 📡 默认配置

| 项目         | 默认值               |
|--------------|----------------------|
| LAN IP       | 192.168.10.1         |
| Web 登录     | admin / thdn12345678 |
| Wi-Fi SSID   | THDN-dayin           |
| Wi-Fi 密码   | thdn12345678         |
| 主机名       | THDN-PrintServer     |

## 🧩 自定义说明

- 修改 `config/ar9531_defconfig` 可调整固件功能  
- 修改 `files/etc/config/*` 可调整默认配置  
- 修改 `files/etc/uci-defaults/*` 可添加启动脚本  

## 📄 许可证

MIT License  
Copyright © 2025 THDN-PrintServer Project
