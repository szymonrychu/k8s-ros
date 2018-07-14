#!/bin/bash
HEAD=$(git rev-parse HEAD)
for CONTAINER in 'base' 'roscore' 'gui' 'freenect' 'gui-freenect' 'rgbdslam'
do
    docker build -t szymonrychu/ros-${CONTAINER}:latest -f Dockerfile_$( echo "$CONTAINER" | tr '-' '_') .
    docker tag szymonrychu/ros-${CONTAINER}:latest szymonrychu/ros-${CONTAINER}:${HEAD}
    docker push szymonrychu/ros-${CONTAINER}:${HEAD} 
    docker push szymonrychu/ros-${CONTAINER}:latest
done

docker tag szymonrychu/ros-rgbdslam:latest szymonrychu/ros:latest
docker tag szymonrychu/ros-rgbdslam:latest szymonrychu/ros:${HEAD}
docker push szymonrychu/ros:${HEAD}
docker push szymonrychu/ros:latest
