curl -X POST http://localhost:7201/api/v1/database/create -d '{
  "type": "cluster",
  "namespaceName": "test",
  "retentionTime": "168h",
  "numShards": "8",
  "replicationFactor": "1",
  "hosts": [
        {
            "id": "m3db-dev01-yubo.py",
            "isolationGroup": "g1",
            "zone": "embedded",
            "weight": 100,
            "address": "10.178.24.87",
            "port": 9000
        }
    ]
}'
