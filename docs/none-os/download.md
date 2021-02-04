---
layout: default
title: 下载与安装
nav_order: 3
permalink: /docs/download
---

# 下载


[0.002版2021.2.4（800M）](https://pan.baidu.com/s/1I3varnZplIA5h8mrmd2LoQ)
提取码: 72xn

Emacs版本26.1

升级内容：

第一版竟然无法显示光标，这一版解决了这个问题。

## 关于硬件

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


## ssh（远程登录）

ssh pi@192.168.1.2

以上的ip只是例子

如果发生ssh key错乱，如果你用的mac，可以执行：

rm -f ~/.ssh/known_hosts


## 首先添加国内源

终端输入
```js
sudo nano /etc/apt/sources.list
```
把他自己的注释掉，就是最前面添加一个#

```js
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ buster main non-free contrib
```
ctrl+o储存

ctrl+x退出


随后同样操作另外一个文件
```js
sudo nano /etc/apt/sources.list.d/raspi.list
```

```js
deb http://mirrors.tuna.tsinghua.edu.cn/raspberrypi/ buster main ui
```


## 中文显示与中文输入

这里特别感谢Ubuntu中国论坛的一位版主的热心教学

[原帖](https://forum.ubuntu.org.cn/viewtopic.php?f=8&t=491820)

首先最小化安装fbterm和输入法

```js
sudo apt install --no-install-recommends fbterm fcitx-module-dbus dbus-x11 fcitx-frontend-fbterm fcitx-pinyin fonts-wqy-microhei
```

```js
sudo setcap 'cap_sys_tty_config+ep' /usr/bin/fbterm
```

```js
sudo adduser $USER video
```

```js
fcitx
nano ~/.config/fcitx/profile
```


## .bashrc配置

这里是一些自动启动的相关配置，比如进入fbterm和开启输入法之类的。

```js
clear
# 这个大家也可以自定义
PS1="别:"
# 在后台进入输入法，因为输入法有莫名报错信息（不影响使用）
(fcitx &) > /dev/null 2>&1
fbterm

#让fbterm显示256色
export TERM=fbterm

#直接打开emacs
emacs -nw
```

## .fbtermrc配置

这里可以自定义字体以及字体大小。

尤其字体大小部分，请使用者非常注意，因为每个人的屏幕像素不一样，所以也请根据情况修改。

```js
# 你可以添加自己的字体，具体方法后面放出
font-names=KKong,mono
font-size=50
# 背景颜色和文字颜色
color-foreground=7
color-background=0
# 这个也许不是必须
text-encodings=UTF-8
# 我把光标调整成了方块，因为在fbterm下面，下滑线的光标经常自己消失。。。
cursor-shape=1 
# 光标不闪烁，这样和我mac上的基本就一模一样了
cursor-interval=0
# 设置输入法
input-method=fcitx-fbterm
```


## 去掉各种开机文字

这里大家可以根据自己的喜好来取舍，有人喜欢原汁原文的PI，也有人可能喜欢隐藏这些开机文字。

 vim /boot/config.txt
 
 disable_splash=1

vim /boot/cmdline.txt

将里面的 “console=tty1” 换成  “console=tty3”。

在这一行的最后加入，请注意，保持所有内容为一行
splash quiet plymouth.ignore-serial-consoles logo.nologo vt.global_cursor_default=0

让某些启动文字消失
sudo systemctl disable getty@tty3

安装fbi，可以用自己的启动图片
sudo apt install fbi

建立新设置文档
sudo vim /etc/systemd/system/splashscreen.service

在新建的文档中输入如下文字

```js
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
```
请注意，在上面正确的目录放置图片，也确保所有名称都是正确的，否则可以引起无法开机。（我就发生过）

要替换自己的logo也是修改上面的目录和文件名。


开启自定义登录画面

sudo systemctl enable splashscreen


隐藏自动登录信息

touch ~/.hushlogin

sudo nano /etc/systemd/system/getty@tty1.service.d/autologin.conf

让其中的：

ExecStart=-/sbin/agetty --autologin pi --noclear %I xterm-256color

替换为：

ExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options "-f pi" %I $TERM

## 安装samba（nas文件系统）

安装samba系统主要是为了之后把字体文件，emacs配置，以及自定义的Logo文件放到PI里头。

同时，自己写的文档，如果你不上传Github的话，也可以通过这个方式传到其他电脑。

```js
sudo apt install samba
sudo touch /etc/samba/smbpasswd
sudo smbpasswd -a pi
```
这里是给pi这个用户设置一个密码，大家自己设置

打开下面这个文档
```js
vim /etc/samba/smb.conf
```

在文档最下方输入如下文字

```js
[None-OS-Share]
	path = /home/pi/share/
	writable = yes
	valid user = pi
	create mask = 0777
```
这里要注意，首先要确保你有/home/pi/share/这个目录
如果没有，那么就建立一个

```js
mkdir share
```

保存退出后，在终端输入如下命令以重启服务

```js
sudo /etc/init.d/smbd restart
```

如此，你查看好本机的ip后
到你的另外一台电脑上的file管理器中输入

```js
smb://192.168.1.2
```
以上的ip是打个比方

最后用户名输入pi
密码输入上面你自己设定的密码

于是就可以传输文件了


# 配置Emacs

你可以直接下载这个配置文件，当然也可以根据自己的喜好自己制作。

这是一个为文本写作设计的配置，可能非常不适合程序员使用。

未来配置文件也会持续更新（也许吧）。

[下载配置](http://none-os.com/docs/none-os/init.el)

将这个配置文件拷贝到你的

> ~/.emacs.d/

为了在emacs上显示256色，需要下载这个文件

[下载文件](http://none-os.com/docs/none-os/fbterm.el)

也同样拷贝到以上目录

第一次运行的时候有可能需要手动安装一个包


# 更换字体

将所有字体放到

/usr/share/fonts/truetype

假设你正在该字体当前目录下

sudo cp KKong.ttf /usr/share/fonts/truetype/

随后，生成字体
sudo fc-cache -v -f

查看已经安装的字体
fc-list

如果要删除某个字体，直接删除字体文件，然后执行
sudo fc-cache -v -f


# 制作镜像

你甚至可以发布自己DIY的镜像！

## 制作镜像

首先列出所有加载的设备

df -th

随后找到自己的U盘是哪个，图片上是我的案例

![](https://s3.ax1x.com/2021/02/04/y1sFVP.png)

我这里是disk6s1，但是在命令中要省去s1

输入：

sudo dd if=/dev/disk6 of=/Users/hua/Desktop/non-os/os-img/none-os-2021-2-4.img

后面是自己定义的目录和文件名

那么这就是制作镜像了，等待一会就完成了。

（请高手告知如何可视化这个过程，就是现实当前进程）


## 压缩镜像

那么所谓的制作镜像就是把你的整个U盘给完整克隆下来，但这往往太大了。

于是需要这个工具,**PiShrink**。

[Git](https://github.com/Drewsif/PiShrink)

国内不太容易下载，那么可以点击这里下载其脚本。

[脚本]()

同时这东西貌似只能在linux上运行，我的m1苹果貌似少什么东西不让运行。。。

先执行：

chmod +x pishrink.sh
sudo mv pishrink.sh /usr/local/bin

然后找到你镜像所在目录，执行：

sudo pishrink.sh pi.img

![](https://s3.ax1x.com/2021/02/04/y1WPSK.png)

基本上就大功告成了。（根据情况不同，压缩率也不同，我大概是15G可压缩到15.-3G左右。随后你还可以zip一下，体积可以缩减到800M左右，期待未来继续缩减体积）

整个过程基本上就是这样了，期待高手指正和优化其中不好的部分，我将非常感谢。
