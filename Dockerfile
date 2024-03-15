FROM ubuntu:latest

# Set environment variable to avoid keyboard selection prompt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    locales \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set default locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install VNC server and set password
RUN mkdir ~/.vnc
RUN echo "179" | vncpasswd -f > ~/.vnc/passwd
RUN chmod 0600 ~/.vnc/passwd

# Expose VNC port
EXPOSE 5901

# Start VNC server
CMD ["vncserver", "-fg", ":1", "-geometry", "1280x800", "-depth", "24"]
