FROM ubuntu:xenial as base

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

ENV DEBIAN_FRONTEND noninteractive
ENV ROS_DISTRO lunar
ENV FREENECT_STACK_URL https://github.com/szymonrychu/freenect_stack
ENV FREENECT_STACK_COMMIT melodic-0.0.1

# install base ros installation
RUN set -xe;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        sudo \
        git \
        lsb-release;\
    useradd -m -s /bin/bash -G sudo,dialout ros;\
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros;\
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116;\
    echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        ros-${ROS_DISTRO}-desktop-full \
        ros-${ROS_DISTRO}-rgbd-launch \
        ros-${ROS_DISTRO}-rtabmap-ros \
        freenect \
        udev \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        build-essential;\
    rosdep init;\
    udevadm control --reload-rules;\
    udevadm trigger
# update rosdep as ros user
USER ros

RUN set -xe;\
    rosdep update;\
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc;\
    echo "export DISPLAY=:1" >> ~/.bashrc;\
    echo "export ROS_DISTRO=${ROS_DISTRO}" >> ~/.bashrc;
    
FROM base AS ros_freenect_compilation

RUN set -xe;\
    mkdir -p ~/build/catkin_ws/src;\
    cd ~/build/catkin_ws/src;\
    git clone ${FREENECT_STACK_URL} .;\
    git checkout ${FREENECT_STACK_COMMIT};\
    rm -Rf .git;\
    cd ~/build/catkin_ws;\
    sudo bash -c "source /opt/ros/${ROS_DISTRO}/setup.bash; catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/${ROS_DISTRO} install"

FROM base as release

COPY --from=ros_freenect_compilation /opt/ros/${ROS_DISTRO} /opt/ros/${ROS_DISTRO}

USER root

RUN set -xe;\
    apt-get install -y --force-yes --no-install-recommends \
        supervisor \
        vim-tiny \
        lxde \
        x11vnc \
        xvfb \
        terminator \
        gtk2-engines-murrine \
        ttf-ubuntu-font-family;\
    mkdir -p /etc/supervisor/conf.d;\
    rm /etc/supervisor/supervisord.conf;\
    cd /root;\
    git clone https://github.com/kanaka/noVNC.git;\
    rm -Rf noVNC/.git;\
    cd noVNC/utils;\
    git clone https://github.com/kanaka/websockify websockify;\
    rm -Rf websockify/.git;\
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /etc/default/supervisor

COPY visual_odometry.launch /opt/ros/${ROS_DISTRO}/share/rtabmap_ros/

COPY supervisord.conf /etc/supervisor/

COPY start_pcl2depth.sh /
COPY start_rtabmap.sh /
COPY start_freenect.sh /
RUN set -xe;\
    sudo chmod +x /start_pcl2depth.sh;\
    sudo chmod +x /start_rtabmap.sh;\
    sudo chmod +x /start_freenect.sh

EXPOSE 6080
 
WORKDIR /home/ros

VOLUME /dev/bus/usb

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]