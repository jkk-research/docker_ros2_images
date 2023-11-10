FROM dustynv/ros:iron-desktop-l4t-r32.7.1

RUN apt-get update \
    && apt-get install -y \
    curl \
    gnupg2 \
    lsb-release \
    nano \
    mc \
    iputils-ping \
    net-tools \
    # ros-iron-rosbag2 \
    # ros-iron-rosbag2-storage-mcap \
    && rm -rf /var/lib/apt/lists*

WORKDIR /home
COPY ./scripts/mcap_entrypoint.sh .
ENTRYPOINT ["/bin/bash", "/home/mcap_entrypoint.sh"]