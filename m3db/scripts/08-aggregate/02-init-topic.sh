# Initializing m3msg topic for m3aggregator to receive from m3coordinators to aggregate metrics
curl -vvvsSf -H "Cluster-Environment-Name: default_env" \
	-H "Topic-Name: aggregator_ingest" \
	-X POST http://localhost:7201/api/v1/topic/init \
	-d '{ "numberOfShards": 16 }'
