FROM drone:jetson

RUN apt-get update \
    && apt-get install -y \
    nano \
    build-essential \
    libeigen3-dev \
    libtins-dev \
    libpcap-dev \
    libpcl-dev \
    libjsoncpp-dev \
    libspdlog-dev \
    libcurl4-openssl-dev \
    cmake \
    ros-humble-pcl-ros \
    ros-humble-tf2-eigen \
    ros-humble-rviz2 \    
    python3-colcon-common-extensions \
    && rm -rf /var/lib/apt/lists*


SHELL [ "/bin/bash", "-c" ]
WORKDIR /home
RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    # && git clone -b humble https://github.com/ros-drivers/ros2_ouster_drivers \
    && git clone -b ros2 --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git \
    && git clone https://github.com/jkk-research/jkk_utils \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/setup.bash \
    # && rosdep install --from-paths src/ -y -r --ignore-src \
    && colcon build --packages-select ouster_ros ouster_sensor_msgs drone_bringup time_utils --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

# ros2 launch drone_bringup lidar1.launch.py
# ros2 launch ouster_ros sensor.launch.xml sensor_hostname:=os-992215001101.local viz:=false

# ros2 topic list
# /drone1/os/imu
# /drone1/os/points



WORKDIR /home
COPY ./scripts/lidar_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/lidar_entrypoint.sh"]