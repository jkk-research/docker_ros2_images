FROM dustynv/ros:humble-ros-core-l4t-r32.7.1

RUN apt-get update \
    && apt-get install -y \
    nano \
    build-essential \
    libtins-dev \
    libpcap-dev \
    libpcl-dev \
    libjsoncpp-dev \
    cmake \
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists*


# pcl_ros
# # RUN mkdir -p /root/ros2_pre_installed/src
# # RUN cd /root/ros2_pre_installed \
# #   && git clone https://github.com/ros-perception/perception_pcl src/perception_pcl \
# #   && cd src/perception_pcl \
# #   && git checkout ros2 \
# #   && cd /root/ros2_pre_installed \
# #   && source $ROS_ROOT/install/setup.bash \
# #   && rosdep install --from-paths src --ignore-src -r -y --rosdistro=$ROS_DISTRO --skip-keys="$ROSDEP_SKIP_PACKAGES" \
# #   && colcon build --merge-install --install-base "$ROS_ROOT/install" --cmake-args -DCMAKE_BUILD_TYPE=Release --packages-up-to pcl_ros
 


WORKDIR /home
RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    && git clone -b ros2 https://github.com/ros-perception/perception_pcl.git \
    && git clone -b ros2 https://github.com/ros-perception/pcl_msgs \
    && git clone -b humble https://github.com/ros-drivers/ros2_ouster_drivers.git \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/install/setup.bash \
    && rosdep install --from-paths src/ -y -r --ignore-src \
    && colcon build --packages-select pcl_msgs pcl_ros pcl_conversions ouster_msgs ros2_ouster --continue-on-error


WORKDIR /home
COPY ./scripts/lidar_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/lidar_entrypoint.sh"]