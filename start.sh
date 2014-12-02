#!/bin/bash

#
# Starts tmpnb server using the jupyter-kernel as the base image
# The idea is that (eventually) this will be an API you can hit to start a new 
# container for a user
# 

#
# Start the docker_ui so I can see what's happening
#
docker run -d -p 9000:9000 -v /var/run/docker.sock:/docker.sock crosbymichael/dockerui -e /docker.sock


export TOKEN=$( head -c 30 /dev/urandom | xxd -p )
docker run --net=host -e CONFIGPROXY_AUTH_TOKEN=$TOKEN --name=proxy jupyter/configurable-http-proxy --default-target http://192.168.59.103:9999

docker run --net=host  \
   -e CONFIGPROXY_AUTH_TOKEN=$TOKEN \
   -v /var/run/docker.sock:/docker.sock \
   jupyter/tmpnb \
   python orchestrate.py --container_ip=0.0.0.0 --image="odewahn/jupyter-kernel" --command="./go.sh" --pool_size=5



echo "Hit ctrl+c to exit..."
while true; do
  : # busy-wait
done