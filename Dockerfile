FROM rockylinux:8.9

COPY compat-db47-4.7.25-28.el7.x86_64.rpm /tmp/compat-db47-4.7.25-28.el7.x86_64.rpm
COPY compat-db-headers-4.7.25-28.el7.noarch.rpm /tmp/compat-db-headers-4.7.25-28.el7.noarch.rpm

#OS tools including XFCE4
RUN dnf install -y epel-release && \
    dnf update -y --allowerasing && \
    dnf groupinstall -y "Server with GUI" --allowerasing && \
    dnf install -y xfce4-panel xfce4-session xfce4-settings xfce4-appfinder xfdesktop xfwm4 \
                   tigervnc-server novnc openssh-server passwd sudo xterm xorg-x11-server-Xvfb

#EDA related
RUN dnf install -y kernel-devel mc git zsh tmux
RUN dnf install -y ksh csh redhat-lsb-core environment-modules openssl-devel openssl-libs libpng12
RUN dnf install -y libXScrnSaver qt5-qtbase-gui qt5-qtbase-gui motif motif-devel
RUN dnf install -y compat-openssl10 mesa-libGLU libnsl apr-util glibc-devel
RUN dnf install -y glibc-devel.i686 glibc-devel
RUN dnf install -y libxcb-devel xcb-util-wm xcb-util-image xcb-util-keysyms xcb-util-renderutil

RUN dnf install -y /tmp/compat-db-headers-4.7.25-28.el7.noarch.rpm
RUN dnf install -y /tmp/compat-db47-4.7.25-28.el7.x86_64.rpm


RUN dnf clean all

# root account
RUN echo "root:myEdaTools25" | chpasswd
RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

# Expose the SSH and VNC port
EXPOSE 22
EXPOSE 5901

###### CMD ["/usr/sbin/sshd","-D"]

COPY run.sh /run.sh
CMD ["/bin/sh", "/run.sh"]