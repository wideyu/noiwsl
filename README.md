# NOIwsl

NOIwsl Script ~ install NOI Linux ISO to WSL

NOIwsl 脚本从NOI Linux 2.0 iso 文件，提取rootfs、安装到WSL、设置远程桌面，实现在Windows远程连接使用NOI Linux的图形桌面。

## 背景
之前以Launcher.exe 方式（[NOIwslLauncher](https://github.com/wideyu/noiwslLauncher) ）导入预制rootfs、设置远程桌面，实现在Windows 远程连接使用NOI Linux的图形桌面。最新版WSL 已支持Systemd，NOIwsl 改为以脚本实现。

## Requirements
* WSL2 latest version
  ```bash
  D:\NOIwsl>wsl --version
  WSL 版本： 2.0.14.0
  内核版本： 5.15.133.1-1
  WSLg 版本： 1.0.59
  ```
* Internet ready

## Install
* Code / Download ZIP, Unzip files to D:\NOIwsl
* Download [ubuntu-noi-v2.0.iso](https://noiresources.ccf.org.cn/ubuntu-noi-v2.0.iso) save to D:\NOIwsl
* Files in D:\NOIwsl
```bash
D:\NOIwsl> dir/b
alpine-sqfs2tar.tar.gz
iso2tar.sh
Setup.cmd
ubuntu-noi-v2.0.iso
xrdp-installer-1.4.8.sh
```
* Open cmd in D:\NOIwsl, Run Setup.cmd 
```bash
D:\NOIwsl> Setup.cmd ubuntu-noi-v2.0.iso /casper/filesystem.squashfs NOIwsl-2.0 usrname
```
* Setup.cmd 参数说明
  ```bash
  ubuntu-noi-v2.0.iso -------- 下载的NOI Linux 2.0 文件
  /casper/filesystem.squashfs ---- iso 内部squshfs 文件
  NOIwsl-2.0 --- WSL Distro 名
  usrname ---- 自定义登录用户名
  ```
* Setup.cmd将执行以下步骤
  ```bash
  0) Import Alpine+squashfs-tools-ng ... 导入sqfs2tar工具
  1) Convert iso->rootfs.tar (iso2tar.sh via Alpine) ... 从iso提取rootfs
  2) Import rootfs.tar ... 导入rootfs
  3) Unregister Alpine ... 注销工具
  4) Adduser usrname ... 按提示输入用户usrname对应的密码
  5) Enable Systemd and set default user ... 启用Systemd、默认用户
  6) xrdp-installer.sh ... 联网安装xrdp、设置远程桌面
  7) Create NOIwsl-2.0.cmd ... 生成打开远程桌面的脚本
  ```
* 运行生成的NOIwsl-2.0.cmd，连接远程桌面，输入用户usrname、密码登录，即可使用NOI Linux 2.0 图形桌面。


## 致谢
* [AlpineLinux](https://alpinelinux.org)
* [squashfs-tools-ng](https://github.com/AgentD/squashfs-tools-ng)
* [xRDP Installation Script](https://c-nergy.be)
* [NOI Linux 2.0](https://www.noi.cn/gynoi/jsgz/2021-07-16/732450.shtml)
