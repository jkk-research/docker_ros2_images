FROM drone:jetson

RUN apt-get update \
    && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    nano \
    mc \
    iputils-ping \
    net-tools \
    ros-humble-rosbag2 \
    ros-humble-rosbag2-storage-mcap \
    python3-colcon-common-extensions \    
    && rm -rf /var/lib/apt/lists*

## TODO: init dir: /home/ros2_ws/src/jkk_utils/drone_bringup/etc && chmod 777 record_mcap1.sh 

SHELL [ "/bin/bash", "-c" ]
WORKDIR /home
RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    && git clone https://github.com/jkk-research/jkk_utils \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/setup.bash \
    && colcon build --packages-select drone_bringup time_utils --symlink-install

WORKDIR /home
COPY ./scripts/mcap_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/mcap_entrypoint.sh"]