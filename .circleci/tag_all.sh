#!/bin/bash
HEAD=$(git rev-parse HEAD)
docker pull szymonrychu/ros-base:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-base:${HEAD} szymonrychu/ros-base:${TAG_NAME}
    docker push szymonrychu/ros-base:${TAG_NAME}
)
docker pull szymonrychu/ros-roscore:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-roscore:${HEAD} szymonrychu/ros-roscore:${TAG_NAME}
    docker push szymonrychu/ros-roscore:${TAG_NAME}
)
docker pull szymonrychu/ros-gui:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-gui:${HEAD} szymonrychu/ros-gui:${TAG_NAME}
    docker push szymonrychu/ros-gui:${TAG_NAME}
)
docker pull szymonrychu/ros-freenect:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-freenect:${HEAD} szymonrychu/ros-freenect:${TAG_NAME}
    docker push szymonrychu/ros-freenect:${TAG_NAME}
)
docker pull szymonrychu/ros-gui-freenect:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-gui-freenect:${HEAD} szymonrychu/ros-gui-freenect:${TAG_NAME}
    docker push szymonrychu/ros-gui-freenect:${TAG_NAME}
)
docker pull szymonrychu/ros-rgbdslam:${HEAD}
TAG_NAME=$(git describe --exact-match --tags ${HEAD}) && (
    docker tag szymonrychu/ros-rgbdslam:${HEAD} szymonrychu/ros-rgbdslam:${TAG_NAME}
    docker push szymonrychu/ros-rgbdslam:${TAG_NAME}
)