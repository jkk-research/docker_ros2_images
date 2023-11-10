# docker_ros2_images
ROS2 docker images

### Pull original image
``` bash
docker pull dustynv/ros:humble-ros-core-l4t-r32.7.1
```

``` bash
docker pull dustynv/ros:iron-desktop-l4t-r32.7.1
```


### Run GPS Image
```bash
docker run -it --rm --privileged=true --network=host --name gps1 drone:gps
```

``` bash
ros2 launch duro_gps_driver duro_example.launch.py
```

### Run MCAP Image
```bash
docker run -it --rm -v /home/nvidia/bag/:/bag --privileged=true --network=host --name mcap1 drone:mcap 
```

### Run LIDAR Image
```bash
docker run -it --rm --privileged=true --network=host --name lidar1 drone:lidar
```


## Related
- Wiki page: https://github.com/szenergy/szenergy-public-resources/wiki/ROS-2-humble-jeston-docker
- Docker hub `dustynv/ros`: [https://hub.docker.com/r/dustynv/ros](https://hub.docker.com/r/dustynv/ros/tags?page=1&name=humble)
- Jetson containers repo: https://github.com/dusty-nv/jetson-containers