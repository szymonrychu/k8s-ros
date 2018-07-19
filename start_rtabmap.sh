#!/bin/bash
source /opt/ros/${ROS_DISTRO}/setup.bash
sleep 10
roslaunch rtabmap_ros visual_odometry.launch rtabmap_args:="--delete_db_on_start" rviz:=true rtabmapviz:=false