#!/bin/bash
# docker build -t local/ros_gui -f Dockerfile_gui .
open -a XQuartz
# socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
# IP="127.0.0.1"
xhost + $(hostname)
docker run -it \
    -e DISPLAY=$(hostname):0 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
     --privileged local/ros_gui rosrun rviz rviz