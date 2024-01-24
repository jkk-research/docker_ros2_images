#!/bin/bash
docker build -f jetson.Dockerfile -t drone:jetson .
docker build -f gps.Dockerfile -t drone:gps .
docker build -f mcap.Dockerfile -t drone:mcap .
docker build -f lidar.Dockerfile -t drone:lidar .
docker build -f robosense_lidar.Dockerfile -t drone:robosense_lidar .