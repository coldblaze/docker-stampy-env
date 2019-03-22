FROM ubuntu:latest

LABEL maintainer="https://github.com/coldblaze"

# Install sshd, Python3, PyGObject and packages for Korean
RUN apt-get update -qq -y \
 && apt-get install -qq -y \
    locales \
    language-pack-ko \
 && locale-gen ko_KR.UTF-8 \
 && update-locale LANG=ko_KR.UTF-8 LC_MESSAGES=POSIX \
 && apt-get install -qq -y openssh-server \
 && echo 'root:root'|chpasswd \
 && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
 && sed -ri 's/^#?X11Forwarding\s+.*/X11Forwarding yes/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?X11DisplayOffset\s+.*/X11DisplayOffset 10/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?X11UseLocalhost\s+.*/X11UseLocalhost no/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?PrintMotd\s+.*/PrintMotd no/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?PrintLastLog\s+.*/PrintLastLog yes/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?ClientAliveInterval\s+.*/ClientAliveInterval 30/' /etc/ssh/sshd_config \
 && sed -ri 's/^#?ClientAliveCountMax\s+.*/ClientAliveCountMax 60/' /etc/ssh/sshd_config \
 && apt-get install -qq -y \
    net-tools \
    iputils-ping \
    fonts-nanum fonts-nanum-extra nabi \
    python3 python3-pip \
    python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
    libwebkitgtk-3.0-dev \
    libgl1-mesa-glx \
    dbus-x11 \
    cmake \
    glade \
    epiphany-browser \
 && echo "export XMODIFIERS=@im=nabi" >> /root/.bashrc \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip3 install evernote3

ENV LANG=ko_KR.UTF-8
ENTRYPOINT service ssh restart && bash
WORKDIR /root
