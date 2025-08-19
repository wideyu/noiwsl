# NOIwsl

NOIwsl Script ~ install NOI-Linux to WSL, use NOI-Linux full desktop in Windows.

NOIwsl 脚本从NOI Linux 2.0 iso 文件，提取rootfs、安装到WSL、设置WSLg (Wayland)，实现在Windows中直接使用完整的NOI-Linux的图形桌面。

## 背景
* 之前以Launcher.exe 方式（[NOIwslLauncher](https://github.com/wideyu/noiwslLauncher) ）导入预制rootfs、设置远程桌面，实现在Windows 远程连接使用NOI Linux的图形桌面。
* 再以脚本实现xrdp方式远程使用NOI Linux的图形桌面。WSL2支持Systemd。
* 最新版参考[Full desktop shell in WSL2 using WSLg (Wayland)](https://gist.github.com/tdcosta100/7def60bccc8ae32cf9cacb41064b1c0f)，以wslg方式使用NOI Linux的图形桌面。
## Requirements
* 联网更新WSL
  ```bash
  wsl.exe --update
  ```
* 已测试版本
  ```bash
  WSL 版本: 2.5.9.0
  内核版本: 6.6.87.2-1
  WSLg 版本: 1.0.66
  MSRDC 版本: 1.2.6074
  Direct3D 版本: 1.611.1-81528511
  DXCore 版本: 10.0.26100.1-240331-1435.ge-release
  Windows: 10.0.26100.4202
  ```

## Install
* Download ZIP（Code or Releases）, Unzip files to D:\NOIwsl
* Files in D:\NOIwsl
  ```bash
  D:\NOIwsl> dir/b
  alpine-add-pv.tar.gz
  iso2tar.sh
  Setup.cmd
  ```
* Open cmd in D:\NOIwsl, Run Setup.cmd 
  ```bash
  D:\NOIwsl> Setup.cmd usrname
  ```
* usrname 参数为自定义登录用户名
* Setup.cmd 将执行以下步骤
  ```bash
  0. 导入iso2tar.sh脚本      wsl.exe --import alpine-add-pv alpine-add-pv alpine-add-pv.tar.gz --version 2
  1. 提取rootfs可自动iso下载  wsl.exe -d alpine-add-pv -u root -e ./iso2tar.sh ubuntu-noi-v2.0.iso /casper/filesystem.squashfs /root/rootfs.tar
  2. 导入NOI-Linux文件系统   wsl.exe --import noiwsl2 .\vhdx-noiwsl2 \\wsl.localhost\alpine-add-pv/root/rootfs.tar --version 2
  3. 注销iso2tar.sh脚本      wsl.exe --unregister alpine-add-pv
  4. 运行wslg-fix.sh脚本     wsl.exe -d noiwsl2 -u root -e ./wslg-fix.sh 
  5. 设置用户密码            wsl.exe -d noiwsl2 -u root adduser --quiet --gecos '' usrname 
  6. 启用Systemd、默认用户    Enable Systemd and set default user usrname 
  ```
* 打开NOI-Linux终端，在windows运行
  ```bash
  wsl.exe -d noiwsl2
  ```
* 打开NOI-Linux图像桌面，在NOI-Linux终端运行
  ```bash
  wslgnome &
  ```
* 分辨率可修改启动文件内 MUTTER_DEBUG_DUMMY_MODE_SPECS=1600x900
  ```bash
  sudo nano /usr/local/sbin/wslgnome
  ```


## 致谢
* [Full desktop shell in WSL2 using WSLg (Wayland)](https://gist.github.com/tdcosta100/7def60bccc8ae32cf9cacb41064b1c0f)
* [AlpineLinux](https://alpinelinux.org)
* [NOI Linux 2.0](https://www.noi.cn/gynoi/jsgz/2021-07-16/732450.shtml)

  [squashfs-tools-ng](https://github.com/AgentD/squashfs-tools-ng)
  
  [xRDP Installation Script](https://c-nergy.be)
