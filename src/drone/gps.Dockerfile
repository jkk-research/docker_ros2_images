FROM drone:jetson

RUN apt-get update \
    && apt-get install -y \
    nano \
    build-essential \
    pkg-config \
    cmake \
    python3-colcon-common-extensions \
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
    && make install

SHELL [ "/bin/bash", "-c" ]
WORKDIR /home
RUN mkdir -p /home/ros2_ws/src \
    && cd /home/ros2_ws/src \
    && git clone -b ros2-humble https://github.com/szenergy/duro_gps_driver \
    && git clone https://github.com/jkk-research/jkk_utils \
    && cd /home/ros2_ws \
    && source /opt/ros/humble/setup.bash \
    && colcon build --packages-select duro_gps_driver drone_bringup

## ros2 launch drone_bringup gps1.launch.py
## ros2 launch duro_gps_driver duro_example.launch.py

# ros2 topic list
# /drone1/gps/duro/current_pose
# /drone1/gps/duro/imu
# /drone1/gps/duro/mag
# /drone1/gps/duro/navsatfix
# /drone1/gps/duro/status_flag
# /drone1/gps/duro/status_string
# /drone1/gps/duro/time_ref

WORKDIR /home
COPY ./scripts/gps_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/gps_entrypoint.sh"]
 