FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install VNC server and set password
RUN mkdir ~/.vnc
RUN echo "147" | vncpasswd -f > ~/.vnc/passwd
RUN chmod 0600 ~/.vnc/passwd

# Expose VNC port
EXPOSE 5901

# Start VNC server
CMD ["vncserver", "-fg", ":1", "-geometry", "1280x800", "-depth", "24"]
