#!/bin/bash

ulimit -n 3000000
M3DB_HOST_ID=m3db002 ./bin/m3dbnode -f ./etc/m3dbnode.yml

exit
# M3DB_HOST_ID=m3db002 ./bin/m3dbnode -f ./etc/m3dbnode.yml
# -p 7201:7201 -p 7203:7203 -p 9003:9003 \
docker run -d --name m3db \
	--ulimit nofile=3000000:3000000 \
	--network host \
	-e M3DB_HOST_ID=m3db002 \
	-v /opt/data:/opt/data \
	-v $(pwd)/etc/m3dbnode.yml:/etc/m3dbnode/m3dbnode.yml \
	quay.io/m3db/m3dbnode:latest
