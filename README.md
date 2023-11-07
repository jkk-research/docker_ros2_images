# docker_ros2_images
ROS2 docker images

### Run GPS Image
```bash
docker run -it --rm --privileged=true --network=host --name gps drone:gps
```

## Related
- Wiki page: https://github.com/szenergy/szenergy-public-resources/wiki/ROS-2-humble-jeston-docker
- Docker hub `dustynv/ros`: [https://hub.docker.com/r/dustynv/ros](https://hub.docker.com/r/dustynv/ros/tags?page=1&name=humble)