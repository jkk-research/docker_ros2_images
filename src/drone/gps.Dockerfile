FROM dustynv/ros:humble-ros-core-l4t-r32.7.1

RUN apt-get update \
    && apt-get install -y \
    nano \
    build-essential \
    pkg-config \
    cmake \
    doxygen \
    check \
    && rm -rf /var/lib/apt/lists*

WORKDIR /home
RUN git clone https://github.com/swift-nav/libsbp.git
WORKDIR /home/libsbp/c
RUN git submodule update --init --recursive \
    && mkdir build \
    && cd build \
    && cmake ../ \
    && make \
    && sudo make install

RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    && git clone https://github.com/szenergy/duro_gps_driver \
    && cd /home/ros2_ws/src/duro_gps_driver \
    && git checkout ros2-humble \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/install/setup.bash \
    && colcon build --packages-select duro_gps_driver

WORKDIR /home
COPY ./scripts/gps_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/gps_entrypoint.sh"]
 