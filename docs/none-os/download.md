---
layout: default
title: 下载与安装
nav_order: 3
permalink: /docs/download
---

# 下载


[0.001版2021.2.3（800M）](https://pan.baidu.com/s/1MswQOyTAMqt5TyXvqo3YNw)
提取码: gcwq 

我推荐使用PI4，虽然在P Zero W上也测试成功，但是Zero几乎比PI4慢3倍。

PI4 开机到可写作30秒，PI Zero要1分30秒，打开较大文件也耗时太久，同时文字量超过70万字时，打字略有卡顿。

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

## .bashrc配置

这里是一些自动启动的相关配置，比如进入fbterm和开启输入法之类的。


## 去掉各种开机文字

这里大家可以根据自己的喜好来取舍，有人喜欢原汁原文的PI，也有人可能喜欢隐藏这些开机文字。

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
ExecStart=/usr/bin/fbi -d /dev/fb0 --noverbose -a /home/pi/share/bootlogo.png
StandardInput=tty
StandardOutput=tty

[Install]
WantedBy=sysinit.target


sudo systemctl enable splashscreen


touch ~/.hushlogin

sudo nano /etc/systemd/system/getty@tty1.service.d/autologin.conf

ExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options "-f pi" %I $TERM

## 安装samba（nas文件系统）

安装samba系统主要是为了之后把字体文件，emacs配置，以及自定义的Logo文件放到PI里头。

同时，自己写的文档，如果你不上传Github的话，也可以通过这个方式传到其他电脑。

# 配置Emacs

你可以直接下载这个配置文件，当然也可以根据自己的喜好自己制作。

这是一个为文本写作设计的配置，可能非常不适合程序员使用。

未来配置文件也会持续更新（也许吧）。

[下载配置]()
