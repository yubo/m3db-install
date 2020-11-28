curl -vvvsSf -H "Cluster-Environment-Name: default_env" \
	-H "Topic-Name: aggregated_metrics" \
	-X POST http://m3dbnode-with-embedded-coordinator:7201/api/v1/topic \
	-d '{
  "consumerService": {
    "serviceId": {
      "name": "m3coordinator",
      "environment": "default_env",
      "zone": "embedded"
    },
    "consumptionType": "SHARED",
    "messageTtlNanos": "300000000000"
  }
}'
