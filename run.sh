mkdir -p /var/run/sshd
ssh-keygen -A
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

#Create a user and give ssh access
useradd -m dockeruser  
echo "dockeruser:xfce4" | chpasswd
chown -R dockeruser:dockeruser /home/dockeruser
chmod 700 /home/dockeruser
mkdir -p /home/dockeruser/.ssh
chown -R dockeruser:dockeruser /home/dockeruser/.ssh
chmod 700 /home/dockeruser/.ssh

#give the user sudo privileges
usermod -aG wheel dockeruser

#Configure vnc
mkdir -p /home/dockeruser/.vnc
echo "irFtOvonFXCFMHCfoHmiY2sVfIOLH1E5" | vncpasswd -f > /home/dockeruser/.vnc/passwd
chown -R dockeruser:dockeruser /home/dockeruser/.vnc
chmod 600 /home/dockeruser/.vnc/passwd
dbus-uuidgen | tee /var/lib/dbus/machine-id
printf "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &" > /home/dockeruser/.vnc/xstartup
chmod +x /home/dockeruser/.vnc/xstartup

# start ssh and vnc
/usr/sbin/sshd
rm -rf /tmp/.X*
su - dockeruser -c "vncserver :1 -geometry 1280x1024 -depth 24 -SecurityTypes None"
rm /run/nologin
tail -f /dev/null

