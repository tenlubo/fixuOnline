#!/bin/bash

docker pull tenlubo/nginx-demo-bikefresco:latest
docker run --name nginx -p 80:80 tenlubo/nginx-demo-bikefresco:latest

