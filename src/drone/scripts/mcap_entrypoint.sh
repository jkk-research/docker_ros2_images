#!/bin/bash

LSB_REL=$(lsb_release -rs)

echo "ROS_DISTRO: $ROS_DISTRO LSB_REL: $LSB_REL"

source /opt/ros/$ROS_DISTRO/setup.bash
source /home/ros2_ws/install/local_setup.bash

/bin/bash