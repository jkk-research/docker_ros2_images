FROM dustynv/ros:humble-ros-core-l4t-r32.7.1

RUN apt-get update \
    && apt-get install -y \
    nano \
    && rm -rf /var/lib/apt/lists*

ENTRYPOINT ["/bin/bash", "scripts/gps_entrypoint.sh"]
CMD ["bash"]