#!/bin/bash
# https://github.com/m3db/m3/blob/master/docs/how_to/aggregator.md
typ=$1
case "$1" in
"1")
	curl -vvvsSf -H "Cluster-Environment-Name: namespace/test" \
		-X POST http://localhost:7201/api/v1/services/m3aggregator/placement/init -d '{
	    "num_shards": 16,
	    "replication_factor": 2,
	    "instances": [
		{
		    "id": "m3db-dev01-yubo.py:6000",
		    "isolation_group": "availability-zone-a",
		    "zone": "embedded",
		    "weight": 100,
		    "endpoint": "m3db-dev01-yubo.py:6000",
		    "hostname": "m3db-dev01-yubo.py",
		    "port": 6000
		},
		{
		    "id": "m3db-dev02-yubo.py",
		    "isolation_group": "availability-zone-b",
		    "zone": "embedded",
		    "weight": 100,
		    "endpoint": "m3db-dev01-yubo.py:6000",
		    "hostname": "m3db-dev01-yubo.py",
		    "port": 6000
		}
	    ]
	}' 
;;
"2")
	curl -vvvsSf -H "Cluster-Environment-Name: namespace/test" \
		-H "Topic-Name: aggregator_ingest" -X POST http://localhost:7201/api/v1/topic/init \
	-d '{
	    "numberOfShards": 64
	}'
;;
"3")
	curl -vvvsSf -H "Cluster-Environment-Name: namespace/test" \
		-H "Topic-Name: aggregator_ingest" \
		-X POST http://localhost:7201/api/v1/topic \
		-d '{
	  "consumerService": {
	    "serviceId": {
	      "name": "m3aggregator",
	      "environment": "namespace/m3db-cluster-name",
	      "zone": "embedded"
	    },
	    "consumptionType": "REPLICATED",
	    "messageTtlNanos": "300000000000"
	  }
	}'
;;
*)
	echo "usage: ${0}"
	echo "	1: Initializing aggregator topology"
	echo "	2: Initializing m3msg topic for m3aggregator to receive from m3coordinators to aggregate metrics"
	echo "	3: Add m3aggregagtor consumer group to ingest topic"
	echo "	4: Initializing m3msg topic for m3coordinator to receive from m3aggregator to write to M3DB"
	echo "	5: Initializing m3coordinator topology"
	echo "	6: Add m3coordinator consumer group to outbound topic"
;;
esac


