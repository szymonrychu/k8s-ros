FROM ros:melodic as base

ENV FREENECT_STACK_URL https://github.com/szymonrychu/freenect_stack
ENV FREENECT_STACK_COMMIT melodic-0.0.1

RUN set -xe;\
    apt-get update;\
    apt-get install -y --no-install-recommends \
        sudo \
        git \
        lsb-release \
        ros-${ROS_DISTRO}-rgbd-launch \
        ros-${ROS_DISTRO}-camera-info-manager \
        ros-${ROS_DISTRO}-diagnostic-updater \
        freenect \
        udev;\
    useradd -m -s /bin/bash -G sudo,dialout ros;\
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros;\
    echo "export DISPLAY=:1" >> ~/.bashrc

RUN set -xe;\
    mkdir -p ~/build/catkin_ws/src;\
    cd ~/build/catkin_ws/src;\
    git clone ${FREENECT_STACK_URL} .;\
    git checkout ${FREENECT_STACK_COMMIT};\
    rm -Rf .git;\
    cd ~/build/catkin_ws;\
    sudo bash -c "\
        source /opt/ros/${ROS_DISTRO}/setup.bash;\
        catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/${ROS_DISTRO} install"

COPY visual_odometry.launch /opt/ros/${ROS_DISTRO}/share/rtabmap_ros/

USER ros

CMD [ "roslaunch", "freenect_launch", "freenect.launch", "depth_registration:=true" ]