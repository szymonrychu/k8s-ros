#!/bin/bash
source /opt/ros/${ROS_DISTRO}/setup.bash
rosrun rtabmap_ros pointcloud_to_depthimage cloud:=/camera/depth/points camera_info:=/camera/rgb/camera_info image_raw:=/camera/depth/points/image_raw image:=/camera/depth/points/image _approx:=false _fill_holes_size:=2 
