---
layout: default
title: 下载与安装
nav_order: 3
permalink: /docs/download
---

# 下载


[0.001版2021.2.3（800M）](https://pan.baidu.com/s/1MswQOyTAMqt5TyXvqo3YNw)
提取码: gcwq 

---

# 如何安装

基本上就是把下载的文件解压后，烧录至mirco sd卡，然后插入pi，启动就可以了。

![](https://s3.ax1x.com/2021/02/04/ylDxKI.png)

[下载树莓派烧录软件](https://www.raspberrypi.org/software/)

## 具体操作

点击CHOOSE OS 然后选择你下载好的None-OS

然后点击CHOOSE SD CARD，选择你的迷你sd卡

最后点击WRITE

等一段时间烧录完成，将SD卡插入PI


# 你也可以DIY。

你也完全可以自己制作这样一个None-OS，下面是大略的步骤：

## 修改键盘配置

我首先遇到的问题是键盘不匹配，因为PI出厂是默认英国，但我们的键盘大部分US制式。




## 首先添加国内源

sudo nano /etc/apt/sources.list

deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib

sudo nano /etc/apt/sources.list.d/raspi.list

deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui

## 中文显示与中文输入

这里特别感谢Ubuntu中国论坛的一位版主的热心教学

[原帖](https://forum.ubuntu.org.cn/viewtopic.php?f=8&t=491820)

sudo apt install --no-install-recommends fbterm fcitx-module-dbus dbus-x11 fcitx-frontend-fbterm fcitx-pinyin fonts-wqy-microhei

sudo setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm

sudo adduser $USER video

fcitx
nano ~/.config/fcitx/profile

fcitx -r
fbterm -i fcitx-fbterm


## 去掉各种开头文字

 /boot/config.txt, add disable_splash=1

cmdline.txt

console=serial0,115200 console=tty3 root=PARTUUID=ac99701a-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait logo.nologo consoleblank=0 loglevel=3 quite vt.global_cursor_default=0 plymouth.enable=0 plymouth.ignore-serial-consoles fastboot noatime nodiratime noram


sudo systemctl disable getty@tty3

sudo apt install fbi

sudo vim /etc/systemd/system/splashscreen.service

[Unit]
Description=Splash screen
DefaultDependencies=no
After=local-fs.target

[Service]
ExecStart=/usr/bin/fbi -d /dev/fb0 --noverbose -a /home/pi/image001.png
StandardInput=tty
StandardOutput=tty

[Install]
WantedBy=sysinit.target


sudo systemctl enable splashscreen


touch ~/.hushlogin

sudo nano /etc/systemd/system/getty@tty1.service.d/autologin.conf

ExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options "-f pi" %I $TERM

## 安装samba（nas文件系统）

