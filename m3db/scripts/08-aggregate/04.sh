# Initializing m3msg topic for m3coordinator to receive from m3aggregator to write to M3DB
curl -vvvsSf \
	-H "Cluster-Environment-Name: default_env" \
	-H "Topic-Name: aggregated_metrics" \
	-X POST http://localhost:7201/api/v1/topic/init \
	-d '{ "numberOfShards": 16 }'
