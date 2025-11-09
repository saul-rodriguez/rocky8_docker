export USERNAME=saul
export USERPASSWORD=dummypsw

mkdir -p /var/run/sshd
ssh-keygen -A
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

#Create a user and give ssh access
useradd -m $USERNAME  
echo "$USERNAME:$USERPASSWORD" | chpasswd
chown -R $USERNAME:$USERNAME /home/$USERNAME
chmod 700 /home/$USERNAME
mkdir -p /home/$USERNAME/.ssh
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 700 /home/$USERNAME/.ssh
cp /root/.bash_profile /home/$USERNAME/.bash_profile
chown $USERNAME:$USERNAME /home/$USERNAME/.bash_profile
chmod 644 /home/$USERNAME/.bash_profile
cp /root/.bashrc /home/$USERNAME/.bashrc
chown $USERNAME:$USERNAME /home/$USERNAME/.bashrc
chmod 644 /home/$USERNAME/.bashrc

#give the user sudo privileges
usermod -aG wheel $USERNAME

#Create EDA pkg and project directories
mkdir /opt
mkdir /opt/tools
ln -s /opt/tools /pkg

#Configure vnc
mkdir -p /home/$USERNAME/.vnc
echo "irFtOvonFXCFMHCfoHmiY2sVfIOLH1E5" | vncpasswd -f > /home/$USERNAME/.vnc/passwd
chown -R $USERNAME:$USERNAME /home/$USERNAME/.vnc
chmod 600 /home/$USERNAME/.vnc/passwd
dbus-uuidgen | tee /var/lib/dbus/machine-id
printf "#!/bin/sh\nunset SESSION_MANAGER\nunset DBUS_SESSION_BUS_ADDRESS\nstartxfce4 &" > /home/$USERNAME/.vnc/xstartup
chmod +x /home/$USERNAME/.vnc/xstartup

# start ssh and vnc
/usr/sbin/sshd
rm -rf /tmp/.X*
su - $USERNAME -c "vncserver :2 -geometry 1280x1024 -depth 24 -SecurityTypes None"
rm /run/nologin
tail -f /dev/null

