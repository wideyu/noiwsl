@echo off

echo: & echo 0) Import Alpine+squashfs-tools-ng ...
set alpine=alpine-sqfs2tar-%RANDOM%
wsl.exe --import %alpine% ./%alpine% alpine-sqfs2tar.tar.gz --version 2

echo: & echo 1) Convert iso to rootfs.tar (iso2tar.sh Alpine+squashfs-tools-ng) ...
wsl.exe -d %alpine% -u root -e ./iso2tar.sh %1 %2 /tmp/rootfs.tar

echo: & echo 2) Import rootfs.tar ...
wsl.exe --import %3 .\data-%3 \\wsl.localhost\%alpine%/tmp/rootfs.tar --version 2

echo: & echo 3) Unregister Alpine ...
wsl.exe --unregister %alpine%
rmdir %alpine%

echo: & echo 4) Adduser %4 ...
wsl.exe -d %3 -u root adduser --quiet --gecos '' %4
wsl.exe -d %3 -u root usermod -aG adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev %4

echo: & echo 5) Enable Systemd and set default user ...
wsl.exe -d %3 -u root echo -e "[boot]\nsystemd=true\n[user]\ndefault=%4" ^> /etc/wsl.conf
wsl.exe -t %3

echo: & echo 6) xrdp-installer.sh ...
wsl.exe -d %3 -u %4 -e ./xrdp-installer-1.4.8.sh -s

echo: & echo 7) Create %3.cmd ...
wsl.exe -d %3 echo -e "@echo off\ncls\necho Don't close, remote desktop depends on this window...\nwsl.exe -d %3 -u root /mnt/c/windows/system32/mstsc.exe /v:\$(hostname -I)" > %3.cmd

echo: & echo Finished.
echo: & echo Execute %3.cmd to connect remote desktop.
