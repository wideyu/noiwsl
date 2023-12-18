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
D:\noiwsl>dir
 驱动器 D 中的卷是 Data
 卷的序列号是 9696-1731

 D:\noiwsl 的目录

2023/12/18  19:33    <DIR>          .
2023/12/17  22:58        14,837,760 alpine-sqfs2tar.tar.gz
2023/12/18  18:25    <DIR>          data-NOIwsl
2023/12/18  18:25                89 iso2tar.sh
2023/12/18  18:42             1,273 Setup.cmd
2023/12/14  14:40     3,631,218,688 ubuntu-noi-v2.0.iso
2023/10/14  15:48            53,600 xrdp-installer-1.4.8.sh
```
