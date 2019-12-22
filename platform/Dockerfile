FROM ros:melodic as base

RUN set -xe;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        sudo \
        git \
        python \
        python-pip;\
    pip install --upgrade pip rosdep rosinstall_generator wstool rosinstall six vcstools;\
    useradd -m -s /bin/bash -G sudo,dialout ros;\
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros;\
    echo "export DISPLAY=:1" >> ~/.bashrc

USER ros

ENV PACKAGE_NAME=platform

RUN set -xe;\
    mkdir -p /home/ros/build/catkin_ws/src;\
    cd /home/ros/build/catkin_ws/;\
    bash -ce "\
        source /opt/ros/${ROS_DISTRO}/setup.bash;\
        catkin_make";\
    cd /home/ros/build/catkin_ws/src/;\
    bash -ce "\
        source /opt/ros/${ROS_DISTRO}/setup.bash;\
        catkin_create_pkg ${PACKAGE_NAME} message_generation rospy";\
    rm -rf ${PACKAGE_NAME}

COPY platform /home/ros/build/catkin_ws/src/platform

WORKDIR /home/ros/build/catkin_ws

RUN cd /home/ros/build/catkin_ws;\
    sudo bash -ce "\
        source /home/ros/build/catkin_ws/devel/setup.bash;\
        catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/${ROS_DISTRO} install"

CMD [ "rosrun", "platform", "platform" ]