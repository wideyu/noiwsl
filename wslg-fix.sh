#!/bin/sh

apt -y remove zsys acpi-support acpid 
systemctl mask gdm.service
cat << EOF > /etc/systemd/system/wslg-fix.service
[Service]
Type=oneshot
ExecStart=-/usr/bin/umount /tmp/.X11-unix
ExecStart=/usr/bin/rm -rf /tmp/.X11-unix
ExecStart=/usr/bin/mkdir /tmp/.X11-unix
ExecStart=/usr/bin/chmod 1777 /tmp/.X11-unix
ExecStart=/usr/bin/ln -s /mnt/wslg/.X11-unix/X0 /tmp/.X11-unix/X0

[Install]
WantedBy=multi-user.target
EOF
systemctl enable wslg-fix.service
mkdir /etc/systemd/user/gnome-shell-wayland.service.d/
cat << EOF > /etc/systemd/user/gnome-shell-wayland.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/gnome-shell --nested
EOF

cat << EOF > /usr/local/sbin/wslgnome
#!/bin/sh

DESKTOP_SESSION=ubuntu \\
GDMSESSION=ubuntu \\
GNOME_SHELL_SESSION_MODE=ubuntu \\
GTK_IM_MODULE=ibus \\
GTK_MODULES=gail:atk-bridge \\
IM_CONFIG_CHECK_ENV=1 \\
IM_CONFIG_PHASE=1 \\
QT_ACCESSIBILITY=1 \\
QT_IM_MODULE=ibus \\
XDG_CURRENT_DESKTOP=ubuntu:GNOME \\
XDG_DATA_DIRS=/usr/share/ubuntu:\$XDG_DATA_DIRS \\
XDG_SESSION_TYPE=wayland \\
XMODIFIERS=@im=ibus \\
MUTTER_DEBUG_DUMMY_MODE_SPECS=1600x900 \\
gnome-session
EOF
chmod +x /usr/local/sbin/wslgnome