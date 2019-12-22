FROM ros:melodic as base

# install base ros installation
RUN set -xe;\
    useradd -m -s /bin/bash -G sudo,dialout ros;\
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros

RUN set -xe;\
    apt-get update;\
    apt-get install -y --force-yes --no-install-recommends \
        supervisor \
        vim-tiny \
        lxde \
        x11vnc \
        xvfb \
        terminator \
        gtk2-engines-murrine \
        ttf-ubuntu-font-family \
        ros-${ROS_DISTRO}-desktop-full \
        ros-${ROS_DISTRO}-rviz;\
    mkdir -p /etc/supervisor/conf.d;\
    rm /etc/supervisor/supervisord.conf;\
    cd /root;\
    git clone https://github.com/kanaka/noVNC.git;\
    rm -Rf noVNC/.git;\
    cd noVNC/utils;\
    git clone https://github.com/kanaka/websockify websockify;\
    rm -Rf websockify/.git;\
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/default/supervisor

COPY supervisord.conf /etc/supervisor/

EXPOSE 6080
 
USER ros
WORKDIR /home/ros

VOLUME /dev/bus/usb

CMD ["rosrun", "rviz", "rviz"]