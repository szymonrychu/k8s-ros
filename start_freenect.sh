#!/bin/bash
source /opt/ros/${ROS_DISTRO}/setup.bash
roslaunch freenect_launch freenect.launch depth_registration:=true