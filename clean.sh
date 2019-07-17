#!/bin/bash
docker stop $(docker ps -a |grep javaproject | awk '{print $1}' | head -1) || docker ps -a
docker rm $(docker ps -a |grep javaproject | awk '{print $1}' | head -1) || docker ps -a
