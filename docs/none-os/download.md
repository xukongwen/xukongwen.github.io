---
layout: default
title: 測試
nav_order: 2
permalink: /docs/download
---

# i3

https://github.com/Airblader/i3/wiki/Building-from-source

git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

## compile
mkdir -p build && cd build
meson ..
ninja

## 状态栏
sudo apt install i3status

## 搜索
rofi

# termite

要先安装i3，否则有个包没有

https://github.com/Corwind/termite-install

## termite 设置

mkdir ./config/termite/

cp /etc/xdg/termite/config ~/.config/termite/config


# 显示磁盘

>lsblk

sudo dd if=/dev/zero of=/dev/mmblk1

orange pi无法刷manjor的镜像，hdmi有问题


# armbian fcitx

apt-get install im-config

apt-get install fcitx

apt-get install fcitx-frontend-all

apt-get install fcitx-frontend-fbterm

apt-get install -f

apt-get install fcitx-ui-classic

apt-get install fcitx-module-kimpanel

apt-get install fcitx-ui-light

apt-get install fcitx-frontend-gtk3

apt-get install fcitx-config-gtk

# armbian chinese

sudo apt-get insall aptitude

sudo dpkg-reconfigure locales

sudo nano /etc/default/locale

apt-get install ttf-wqy-zenhei -y # 中文字体
apt-get install xfonts-intl-chinese
apt-get install xfonts-wqy

sudo nano /etc/X11/Xsession.d/95xinput

/usr/bin/scim -d
XMODIFIERS="@im=SCIM"
export XMODIFIERS
export GTK_IM_MODULE=scim
