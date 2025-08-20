# NOIwsl

NOI Linux full desktop GUI in Windows WSL2/WSLg.
在 Windows WSL2/WSLg 安装 NOI Linux 完整图形桌面。

NOIwsl 脚本从 NOI Linux 2.0 iso 文件，提取rootfs、安装到WSL、设置WSLg (Wayland)，实现在Windows中直接使用完整的NOI Linux的图形桌面。

* 最初以Launcher.exe 方式（[NOIwslLauncher](https://github.com/wideyu/noiwslLauncher) ），导入预制支持systemd的rootfs、设置远程桌面，实现在Windows远程连接使用NOI Linux的图形桌面。
* 然后以脚本方式，提取rootfs、安装到WSL、设置xrdp远程使用NOI Linux的图形桌面，WSL2支持Systemd。
* 最新以脚本方式，提取rootfs、安装到WSL、参考[Full desktop shell in WSL2 using WSLg (Wayland)](https://gist.github.com/tdcosta100/7def60bccc8ae32cf9cacb41064b1c0f)，通过WSLg使用NOI Linux的图形桌面。

## Requirements
* 联网更新WSL
  ```bash
  C:\Users\admin> wsl.exe --update
  ```
* 已测试版本
  ```bash
  C:\Users\admin> wsl.exe --version
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
  setup.cmd
  wslg-fix.sh
  ```
* Open cmd in D:\NOIwsl, Run setup.cmd usrname(默认noier) 参数为自定义登录用户名
  ```bash
  D:\NOIwsl> setup.cmd usrname
  ```
* setup.cmd usrname(默认noier) 将执行以下步骤
  ```bash
  0. 导入iso2tar.sh脚本       wsl.exe --import alpine-add-pv alpine-add-pv alpine-add-pv.tar.gz --version 2
  1. 提取rootfs可自动iso下载  wsl.exe -d alpine-add-pv -u root -e ./iso2tar.sh ubuntu-noi-v2.0.iso /casper/filesystem.squashfs /root/rootfs.tar
  2. 导入NOI-Linux文件系统    wsl.exe --import noiwsl2 .\vhdx-noiwsl2 \\wsl.localhost\alpine-add-pv/root/rootfs.tar --version 2
  3. 注销iso2tar.sh脚本       wsl.exe --unregister alpine-add-pv
  4. 运行wslg-fix.sh脚本      wsl.exe -d noiwsl2 -u root -e ./wslg-fix.sh 
  5. 设置用户、用户密码        wsl.exe -d noiwsl2 -u root adduser --quiet --gecos '' usrname 
  6. 启用Systemd、默认用户    Enable Systemd and set default user usrname 
  ```
* 如需打开NOI-Linux终端，在Windows运行
  ```bash
  wsl.exe -d noiwsl2
  ```
* 如需打开NOI-Linux图像桌面，在“wsl.exe -d noiwsl2”打开的NOI Linux终端运行
  ```bash
  $ wslgnome &
  ```
* 分辨率可修改启动文件内 MUTTER_DEBUG_DUMMY_MODE_SPECS=1600x900
  ```bash
  $ sudo nano /usr/local/sbin/wslgnome
  ```
## FAQ
* Why NOIwsl?

在实体机、虚拟机、WSL2安装NOI Linux各有各自的好处，NOIwsl在WSL2提供WSLg方式使用NOI Linux图形桌面。

* How to Restart? 
```bash
# terminate one distro
wsl.exe -l -v
wsl.exe -t noiwsl2
wsl.exe -d noiwsl2
$ wslgnome &

# or just shutdown wsl
wsl.exe --shutdown
wsl.exe -d noiwsl2
$ wslgnome &
```

## 致谢
* [Full desktop shell in WSL2 using WSLg (Wayland)](https://gist.github.com/tdcosta100/7def60bccc8ae32cf9cacb41064b1c0f)
* [AlpineLinux](https://alpinelinux.org)
* [NOI Linux 2.0](https://www.noi.cn/gynoi/jsgz/2021-07-16/732450.shtml)（Ubuntu-NOI 2.0版）已经基于Ubuntu 20.04.1版定制完成，现正式对外发布。根据NOI科学委员会决议，该系统将自2021年9月1日起作为NOI系列比赛和CSP-J/S等活动的标准环境使用。

  [squashfs-tools-ng](https://github.com/AgentD/squashfs-tools-ng)
  
  [xRDP Installation Script](https://c-nergy.be)
