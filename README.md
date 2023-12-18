# NOIwsl

Windows 远程桌面连接NOILinux。WSL已支持Systemd，NOIwsl改为以脚本实现从NOILinux ISO 文件提取rootfs.tar导入wsl。（之前的版本保留[NOIwslLauncher](https://github/wideyu/noiwslLauncher)）

## Requirements
* WSL2 latest version
* Internet ready

## Install
* Code / Download ZIP, Unzip to D:\NOIwsl
* Download [ubuntu-noi-v2.0.iso](https://noiresources.ccf.org.cn/ubuntu-noi-v2.0.iso) save to D:\NOIwsl
* Open cmd in D:\NOIwsl
```bash
D:\NOIwsl> dir
 驱动器 D 中的卷是 Data
 卷的序列号是 9696-1731

 D:\Noiwsl 的目录

2023/12/18  19:33    <DIR>          .
2023/12/17  22:58        14,837,760 alpine-sqfs2tar.tar.gz
2023/12/18  18:25                89 iso2tar.sh
2023/12/18  18:42             1,273 Setup.cmd
2023/12/14  14:40     3,631,218,688 ubuntu-noi-v2.0.iso
2023/10/14  15:48            53,600 xrdp-installer-1.4.8.sh
```
* 安装脚本Setup.cmd 的参数说明：Setup.cmd iso-file squashfs-file DistroName UserName
```bash
D:\NOIwsl> Setup.cmd ubuntu-noi-v2.0.iso /casper/filesystem.squashfs NOIwsl-2.0 usrname
```

参数ubuntu-noi-v2.0.iso、/casper/filesystem.squashfs一般不需要修改

参数NOIwsl-2.0、usrname可按需修改

Setup.cmd将执行以下步骤
  
  0) Import Alpine+squashfs-tools-ng ... 导入sqfs2tar工具
  1) Convert iso->rootfs.tar (iso2tar.sh via Alpine) ... 从iso提取rootfs
  2) Import rootfs.tar ... 导入rootfs
  3) Unregister Alpine ... 注销工具
  4) Adduser usrname ... 按提示输入用户usrname对应的密码
  5) Enable Systemd and set default user ... 启用Systemd、默认用户
  6) xrdp-installer.sh ... 联网安装xrdp、设置远程桌面
  7) Create NOIwsl-2.0.cmd ... 生成打开远程桌面的脚本
* 运行生成的NOIwsl-2.0.cmd，连接NOIwsl的远程桌面，输入用户usrname、密码登录


## 致谢
* [AlpineLinux](https://alpinelinux.org)
* [squashfs-tools-ng](https://github.com/AgentD/squashfs-tools-ng)
* [xRDP Installation Script](https://c-nergy.be)
* [NOI Linux 2.0](https://www.noi.cn/gynoi/jsgz/2021-07-16/732450.shtml)
