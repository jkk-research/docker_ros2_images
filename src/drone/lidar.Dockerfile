FROM drone:jetson

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


SHELL [ "/bin/bash", "-c" ]
WORKDIR /home
RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    && git clone -b humble https://github.com/ros-drivers/ros2_ouster_drivers.git \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/setup.bash \
    # && rosdep install --from-paths src/ -y -r --ignore-src \
    && colcon build --packages-select ouster_msgs ros2_ouster --continue-on-error


WORKDIR /home
COPY ./scripts/lidar_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/lidar_entrypoint.sh"]