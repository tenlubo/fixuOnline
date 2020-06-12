#!/bin/bash

docker pull tenlubo/auto-beton:latest
docker run --name AutoBeton -p 80:80 tenlubo/auto-beton:latest

