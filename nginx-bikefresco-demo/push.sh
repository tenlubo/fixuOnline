#!/bin/bash

docker image build -t nginx-demo-bikefresco:development .
docker tag nginx-demo-bikefresco:development tenlubo/nginx-demo-bikefresco:latest
docker push tenlubo/nginx-demo-bikefresco:latest

