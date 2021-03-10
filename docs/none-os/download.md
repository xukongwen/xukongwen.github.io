---
layout: default
title: 測試
nav_order: 2
permalink: /docs/download
---

# termite

https://github.com/Corwind/termite-install

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
