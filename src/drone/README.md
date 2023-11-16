## GPS

### Build GPS Image

```bash
# run from *repo_root*/src/drone
docker build -f gps.Dockerfile -t drone:gps .
```

### Run GPS Image
```bash
docker run -it --rm --privileged=true --network=host --name gps drone:gps
```

## Pull original image
``` bash
docker pull dustynv/ros:humble-ros-core-l4t-r32.7.1
```

``` bash
docker pull dustynv/ros:iron-desktop-l4t-r32.7.1
```