FROM ros:melodic as base

RUN set -xe;\
    useradd -m -s /bin/bash -G sudo,dialout ros;\
    echo "ros ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ros;\
    echo "export DISPLAY=:1" >> ~/.bashrc

CMD [ "roscore" ]