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
    && git clone https://github.com/RoboSense-LiDAR/rslidar_msg.git \
    && git clone https://github.com/jkk-research/rslidar_sdk.git \
    && cd rslidar_sdk \
    && git submodule init \
    && git submodule update \
    && cd /home/ros2_ws \
    && colcon build --packages-select rslidar_msg rslidar_sdk

WORKDIR /home
COPY ./scripts/robosense_lidar_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/robosense_lidar_entrypoint.sh"]

