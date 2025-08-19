wsl.exe --version
@echo off
REM dir "%~dp0*.*" /b
cd /d "%~dp0"

set alpine=alpine-add-pv
if not exist "%~dp0%alpine%.tar.gz" (
	echo ERROR: "%~dp0%alpine%.tar.gz" file not found
	goto xxx
)
echo: & echo 0. wsl.exe --import %alpine% "%~dp0%alpine%" "%~dp0%alpine%.tar.gz" --version 2
wsl.exe --import %alpine% "%~dp0%alpine%" "%~dp0%alpine%.tar.gz" --version 2

set iso=ubuntu-noi-v2.0.iso
if not exist "%iso%" (
	echo Auto download https://noiresources.ccf.org.cn/download/ubuntu-noi-v2.0.iso...
	curl -LjO "https://noiresources.ccf.org.cn/download/ubuntu-noi-v2.0.iso"
)
if not exist "%iso%" (
	echo ERROR: "%iso%" iso file not found
	goto xxx
)
set iso2tar=./iso2tar.sh
if not exist "%iso2tar%" (
	echo ERROR: "%iso2tar%" file not found
	goto xxx
)
echo: & echo 1. wsl.exe -d %alpine% -u root -e %iso2tar% %iso% "/casper/filesystem.squashfs" /root/rootfs.tar
REM wsl.exe -d %alpine% -u root -e %iso2tar% %iso% "/casper/filesystem.squashfs" /root/rootfs.tar

set noiwsl=noiwsl2
echo: & echo 2. wsl.exe --import %noiwsl% .\vhdx-%noiwsl% \\wsl.localhost\%alpine%/root/rootfs.tar --version 2
wsl.exe --import %noiwsl% .\vhdx-%noiwsl% \\wsl.localhost\%alpine%/root/rootfs.tar --version 2
echo If %noiwsl% already exists, wsl.exe --unregister %noiwsl% first.

echo: & echo 3. wsl.exe --unregister %alpine%
wsl.exe --unregister %alpine%

set fix=./wslg-fix.sh
if not exist "%fix%" (
	echo ERROR: "%fix%" file not found
	goto xxx
)
echo: & echo 4. wsl.exe -d %noiwsl% -u root -e %fix%
wsl.exe -d %noiwsl% -u root -e %fix%

set user=%1
if "%user%"=="" set user="noier"
echo: & echo 5. wsl.exe -d %noiwsl% -u root adduser --quiet --gecos '' %user%
wsl.exe -d %noiwsl% -u root adduser --quiet --gecos '' %user%
wsl.exe -d %noiwsl% -u root usermod -aG adm,dialout,cdrom,floppy,sudo,audio,dip,video,plugdev,netdev %user%

echo: & echo 6. Enable Systemd and set default user %user% ...
wsl.exe -d %noiwsl% -u root echo -e "[boot]\nsystemd=true\n[user]\ndefault=%user%" ^> /etc/wsl.conf
wsl.exe -t %noiwsl%

echo: & echo Usage:
echo Open terminal:      wsl.exe -d %noiwsl%
echo Run full desktop:   wslgnome ^&
echo: & echo Settings:
echo Change resolution:  sudo nano /usr/local/sbin/wslgnome
echo Default resolution: MUTTER_DEBUG_DUMMY_MODE_SPECS=1600x900
echo: 

:xxx
pause