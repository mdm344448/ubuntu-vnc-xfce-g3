# syntax=docker/dockerfile:1.7

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
        xfce4 \
        xfce4-terminal \
        tigervnc-standalone-server \
        novnc \
        websockify \
        dbus-x11 \
        x11-xserver-utils \
        sudo \
        wget \
        curl \
        nano \
        supervisor \
        tini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash headless && \
    echo "headless:headless" | chpasswd && \
    usermod -aG sudo headless

RUN mkdir -p /home/headless/.vnc && \
    chown -R headless:headless /home/headless

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080 5901

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/start.sh"]
