FROM ubuntu:bionic


ENV DEBIAN_FRONTEND noninteractive
ENV ROS_DISTRO melodic
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -q -y \
        dirmngr \
        gnupg2 \
        sudo \
        lsb-release && \
    useradd -m -s /bin/bash -G sudo ros && \
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros && \
    apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 && \
    echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    apt-get update && \
    apt-get install -y ros-${ROS_DISTRO}-desktop-full \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        build-essential && \
    rosdep init

USER ros

RUN rosdep update && \
    echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc


ENTRYPOINT ["bash"]