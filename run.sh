#!/bin/bash

docker pull tenlubo/auto-beton:latest
docker run --name nginx -p 80:80 tenlubo/auto-beton:latest

