#!/bin/bash

docker run -it \
    -v /dev/bus/usb:/dev/bus/usb \
    --privileged local/ros_gui rosrun rviz rviz