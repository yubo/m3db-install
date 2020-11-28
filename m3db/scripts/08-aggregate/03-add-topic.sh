# Add m3aggregagtor consumer group to ingest topic
curl -vvvsSf \
	-H "Cluster-Environment-Name: default_env" \
	-H "Topic-Name: aggregator_ingest" \
	-X POST http://localhost:7201/api/v1/topic \
	-d '{
  "consumerService": {
    "serviceId": {
      "name": "m3aggregator",
      "environment": "default_env",
      "zone": "embedded"
    },
    "consumptionType": "REPLICATED",
    "messageTtlNanos": "300000000000"
  }
}'
