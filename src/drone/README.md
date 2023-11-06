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