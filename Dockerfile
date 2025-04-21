FROM rockylinux:8.9

RUN dnf install -y epel-release && \
    dnf update -y --allowerasing && \
    dnf groupinstall -y "Server with GUI" --allowerasing && \
    dnf install -y xfce4-panel xfce4-session xfce4-settings xfce4-appfinder xfdesktop xfwm4 \
                   tigervnc-server novnc openssh-server passwd sudo xterm xorg-x11-server-Xvfb

RUN dnf clean all

# root account
RUN echo "root:myroot" | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Expose the SSH and VNC port
EXPOSE 22
EXPOSE 5901

###### CMD ["/usr/sbin/sshd","-D"]

COPY run.sh /run.sh
CMD ["/bin/sh", "/run.sh"]